class PoliticianUser < ActiveRecord::Base
  attr_accessible :politician_id, :user_id

  belongs_to :politician
  belongs_to :user
end
