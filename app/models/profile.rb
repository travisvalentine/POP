class Profile < ActiveRecord::Base
  attr_accessible :name, :bio, :birthday, :party_affiliation,
                  :twitter, :job_title

  belongs_to :user
  accepts_nested_attributes_for :user

  validates_presence_of :name, :message => "Name can't be blank."

  validates_presence_of :birthday, :unless => :user_created_from_twitter?

  validates_confirmation_of :birthday, :unless => :user_created_from_twitter?

  validates_confirmation_of :party_affiliation, :unless => :user_created_from_twitter?

  def self.create_with_omniauth(user_id, auth)
    create! do |profile|
      profile.user_id   = user_id
      profile.image     = auth['info']['image'] rescue nil
      profile.location  = auth['info']['location'] rescue ""
      profile.name      = auth["info"]["name"]
      profile.bio       = auth["info"]["description"]
      profile.twitter   = auth["info"]["nickname"]
    end
  end

  def user_created_from_twitter?
    !user.nil? && !user.provider.blank? && !user.uid.blank?
  end

  def problems
    Problem.find_all_by_user_id(self.user_id)
  end

  def solutions
    Solution.find_all_by_user_id(self.user_id)
  end

  def first_name
    name.split(" ")[0] || name
  end

end