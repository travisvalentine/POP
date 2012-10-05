module ProfilesHelper

  def current_user_profile?(profile)
    profile.id == current_user.profile.id
  end

end
