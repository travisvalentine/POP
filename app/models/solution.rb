class Solution < ActiveRecord::Base
  attr_accessible :published_at, :body, :solution, :problem_id, :user_id

  validates :body, :presence => true,
                   :length    => { :in => 20..255 },
                   :exclusion => { :in => %w(kill murder assassinate),
                                   :message => "%{value} is not productive." }

  belongs_to :problem
  belongs_to :user

  has_many :comments

  make_voteable
end
