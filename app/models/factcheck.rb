class Factcheck < ActiveRecord::Base
  belongs_to :solution

  validates :link, :body, :presence => true

end
