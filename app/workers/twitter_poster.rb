class TwitterPoster
  @queue = :twitter_posts

  def self.perform(user_id, message)
    user = User.find(user_id)
    user.post_to_twitter(message)
  end

end