class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :bio, :birthday, :party_affiliation
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :birthday, :presence => true
  validates :party_affiliation, :presence => true
  #validates :bio, :presence => true

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

#  has_attached_file :photo,
 #   :styles => { :normal => "153x220#", :small => "75x108#", :thumb => "54x78#" },
  #  :default_url => 'missing_:style.png',
   # :storage => :s3,
    #:bucket => 'yourturn_profile',
   # :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
    #:s3_credentials => {
    #:access_key_id => ENV['S3_KEY'],
    #:secret_access_key => ENV['S3_SECRET'],
    #},
    #:path => ":attachment/:style/:id.:extension"

#  validates_attachment_size :photo, :less_than => 1.megabytes

end
