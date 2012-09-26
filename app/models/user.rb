class User < ActiveRecord::Base
  attr_accessor     :password
  attr_accessible   :email, :password, :password_confirmation,
                    :profile_attributes, :profile
  before_validation :downcase_email

  has_one           :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_many :problems
  has_many :solutions
  has_many :factchecks
  has_many :comments

  validates_presence_of :email,
                        :message => "Email can't be blank.",
                        :unless => :provider?

  validates_confirmation_of :email, :unless => :provider?

  validates_confirmation_of :password,
                        :unless => :provider?

  validates :email, :uniqueness => true,
                    :length => { :within => 5..50 },
                    :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i },
                    :unless => :provider?

  validates :password, :length => { :within => 4..20, allow_nil: true },
                       :unless => :provider?

  before_save :encrypt_new_password

  make_voter

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  def self.create_with_omniauth(auth)
    puts "Creating new user from Auth response"
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
    puts "User created"
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def legal?
    self.age >= 13
  end

  def age
    now = Date.today
    now.year - self.profile.birthday.year - (self.profile.birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def name
    "#{self.profile.first_name} #{self.profile.last_name}"
  end

protected

  def encrypt_new_password
    return if password.blank?
    self.hashed_password = encrypt(password)
  end

  def provider?
    # hashed_password.blank? || password.present?
    !provider.blank? && super
  end

  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

  def downcase_email
    email = email.downcase if email.present?
  end

end