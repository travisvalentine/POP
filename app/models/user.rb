class User < ActiveRecord::Base
  attr_accessor     :password, :password_confirmation
  attr_accessible   :email, :password, :password_confirmation,
                    :profile_attributes, :profile, :oauth_token,
                    :oauth_secret

  before_validation :downcase_email

  has_one           :profile, :dependent => :destroy

  delegate :first_name, :to => :profile
  delegate :name,       :to => :profile
  delegate :twitter,    :to => :profile

  accepts_nested_attributes_for :profile

  has_many :problems
  has_many :solutions
  has_many :factchecks
  has_many :comments
  has_many :notifications

  has_many :politician_users
  has_many :politicians, :through => :politician_users

  validates_presence_of :password, :on => :create,
                        :unless => :provider?

  # validates_confirmation_of :email, :unless => :provider?

  # validates_confirmation_of :password,
                            # :unless => :provider?

  validates :email, :uniqueness => true,
                    :presence => true,
                    :length => { :within => 5..50 },
                    :format => { :with => /^[^@][\w.+-]+@[\w.-]+[.][a-z]{2,4}$/i },
                    :unless => :provider?

  validates :password, :length => {
                          :within => 6..15,
                          :allow_nil => true
                       },
                       :unless => :provider?

  #validates_associated :profile

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
    create! do |user|
      user.provider     = auth["provider"]
      user.uid          = auth["uid"]
      user.oauth_token  = auth["credentials"]["token"]
      user.oauth_secret = auth["credentials"]["secret"]
    end
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

  def client
    Twitter::Client.new(
      :consumer_key       => ENV["TWITTER_KEY"],
      :consumer_secret    => ENV["TWITTER_SECRET"],
      :oauth_token        => self.oauth_token,
      :oauth_token_secret => self.oauth_secret
    )
  end

  def update_from_omniauth(auth)
    update_attributes(
      :oauth_token  => auth["credentials"]["token"],
      :oauth_secret => auth["credentials"]["secret"]
    )
  end

  def post_to_twitter(message)
    begin
      result = client.update(message)

    rescue Twitter::Error => e
      Rails.logger.debug "Posts to Twitter failing - #{e.class.name} errors"
    end
  end

  def has_address?
    profile.address.present?
  end

  def has_notifications?
    notifications.present?
  end

  def has_unread_notifications?
    unread_notifications.count > 0
  end

  def unread_notifications
    notifications.select { |notification| notification.read == false }
  end

  def has_politicians?
    politicians.present?
  end

  def connected_with_twitter?
    provider.present? && provider == "twitter"
  end

  def create_politicians_from_address(address)
    response = Sunlight::Legislator.all_for(:address => address)
    response.each_pair do |k,v|
      if v
        politician = Politician.find_by_fec_id(v.fec_id)
        unless politician
          politicians.create(:title       => k.to_s.humanize.titleize,
                             :short_title => v.title,
                             :first_name  => v.firstname,
                             :last_name   => v.lastname,
                             :party       => v.party,
                             :twitter     => v.twitter_id,
                             :fec_id      => v.fec_id)
        else
          politician_users.create(:politician_id => politician.id, :user_id => id)
        end
      end
    end
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
