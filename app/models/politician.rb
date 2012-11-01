class Politician < ActiveRecord::Base
  attr_accessible :title, :short_title, :first_name, :last_name,
                  :party, :twitter, :fec_id

  has_many :politician_problems
  has_many :problems, :through => :politician_problems

  has_many :politician_users
  has_many :users, :through => :politician_users

  has_one :widget

  validates :fec_id, :presence => true, :uniqueness => true


  def self.with_problems
    select { |pol| pol.has_problems? }
  end

  def has_problems?
    problems.present?
  end

  def name
    "#{first_name} #{last_name}"
  end

end
