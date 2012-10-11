class Solution < ActiveRecord::Base
  attr_accessible :published_at, :body, :solution,
                  :problem_id, :user_id, :original

  validates :body, :presence => true,
                   :length    => { :in => 20..255 }

  belongs_to :problem
  belongs_to :user

  has_many :comments

  make_voteable

  accepts_nested_attributes_for :problem

  def comments_shortened
    comments[0...3]
  end

  def comments_full
    comments[3..-1]
  end

end
