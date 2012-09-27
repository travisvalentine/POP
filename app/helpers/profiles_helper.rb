module ProfilesHelper

  def current_user_profile?(profile)
    profile == current_user.profile
  end
end
