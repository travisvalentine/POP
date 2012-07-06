class User < ActiveRecord::Base
  attr_accessor :password
  before_validation :downcase_email
  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  validates :email, :uniqueness => true,
                    :presence => true,
                    :length => { :within => 5..50 },
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validates :password, :confirmation => true,
                       :length => { :within => 4..20 },
                       :presence => true,
                       :if => :password_required?

  has_many :problems

  has_many :solutions

  has_many :factchecks
  has_many :comments

  before_save :encrypt_new_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
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

  def excluded_problems
    problems = Problem.all - self.problems
    problems.sort_by{|problem| problem.created_at}.reverse
  end

  protected
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end

  scope :profiles, lambda {
    joins(:profiles).group("users.id") & Profile.id
  }

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

end
