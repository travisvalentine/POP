class PoliticianUser < ActiveRecord::Base
  attr_accessible :politician_id, :user_id

  belongs_to :politician
  belongs_to :user

  validates_uniqueness_of :politician_id, :scope => :user_id
end
