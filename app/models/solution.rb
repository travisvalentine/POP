class Solution < ActiveRecord::Base
  validates :body, :presence => true

  belongs_to :problem, :foreign_key => "problem_id"
  belongs_to :user, :foreign_key => "user_id"

  has_many :comments

end
