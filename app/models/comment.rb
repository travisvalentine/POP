class Comment < ActiveRecord::Base
  attr_accessible :solution_id, :user_id, :body

  belongs_to :solution
  belongs_to :user

  validates :body, :presence => true,
                   :length    => { :in => 20..255 }

  after_create :send_comment_notification

  def send_comment_notification
    Notification.create_from_comment(self.body, self.user_id, self.solution_id)
  end

end
