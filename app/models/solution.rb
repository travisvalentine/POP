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

  after_create :send_solution_notification, :unless => Proc.new{ self.original == true }

  def comments_shortened
    comments[0...3]
  end

  def comments_full
    comments[3..-1]
  end

  def send_solution_notification
    Notification.create_from_solution(self.body, self.user_id, self.problem_id)
  end

end
