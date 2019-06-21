module SessionHelpers
  def authentication_headers_for(user)
    user.create_new_auth_token
  end
end
