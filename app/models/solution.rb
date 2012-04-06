class Solution < ActiveRecord::Base
  validates :body, :presence => true

  belongs_to :problem
  belongs_to :user

  has_many :comments

end
