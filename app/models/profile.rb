class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :bio, :birthday,
                  :party_affiliation, :twitter, :job_title
  belongs_to :user
  accepts_nested_attributes_for :user

  validates_presence_of :first_name, :message => "Name can't be blank."
  validates_presence_of :last_name, :message => "Name can't be blank."
  
  validates_presence_of :birthday, :unless => :user_created_from_twitter?

  validates_confirmation_of :birthday, :unless => :user_created_from_twitter?
  
  validates_confirmation_of :party_affiliation, :unless => :user_created_from_twitter?

  def self.create_with_omniauth(user_id, auth)
    name = auth["info"]["name"].split(" ")
    create! do |profile|
      profile.user_id = user_id
      profile.image = auth['info']['image']
      profile.location = auth['info']['location']
      profile.first_name = name[0]
      profile.last_name = name[1..-1].join(" ")
      profile.bio = auth["info"]["description"]
      profile.twitter = auth["info"]["nickname"]
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def legal
    self.age >= "13"
  end

  def age
    now = Time.now.utc.to_date
    now.year - "#{birthday}".year - ((now.month > "#{birthday}".month || (now.month == "#{birthday}".month && now.day >= "#{birthday}".day)) ? 0 : 1)
  end

  def user_created_from_twitter?
    !user.nil? && !user.provider.blank? && !user.uid.blank?
  end

end