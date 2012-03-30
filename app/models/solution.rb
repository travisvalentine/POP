class Solution < ActiveRecord::Base
  validates :body, :presence => true

  belongs_to :problem
  belongs_to :user, :foreign_key => "user_id"

end
