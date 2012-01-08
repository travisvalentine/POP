class Solution < ActiveRecord::Base
  belongs_to :problem

  validates :body, :presence => true
end
