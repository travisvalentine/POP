class Problem < ActiveRecord::Base
  belongs_to :user
  has_many :solutions

  validates :body, :presence => true
  
end
