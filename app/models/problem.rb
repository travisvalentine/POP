class Problem < ActiveRecord::Base
  validates :body, :presence => true

  belongs_to :user
  
  has_many :solutions

  
end
