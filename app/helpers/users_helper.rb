module UsersHelper

  def other_user_profile?(profile)
    current_user.profile != profile
  end

end
