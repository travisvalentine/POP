class Comment < ActiveRecord::Base
  attr_accessible :solution_id, :user_id, :body

  belongs_to :solution
  belongs_to :user

  validates :body, :presence => true,
                   :length    => { :in => 20..255 }

end
