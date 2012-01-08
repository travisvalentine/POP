class Comment < ActiveRecord::Base
  belongs_to :solution

  validates :body, :presence => true

end
