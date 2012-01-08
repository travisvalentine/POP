class Problem < ActiveRecord::Base
  belongs_to :user
  
  validates :body, :presence => true
  
end
