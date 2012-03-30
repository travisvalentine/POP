class Problem < ActiveRecord::Base

  validates :body, :presence => true

  belongs_to :user
  
  has_many :solutions
  accepts_nested_attributes_for :solutions

  validates_presence_of :solutions
  
end
