class Api::V1::BaseApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  # FIXME: devise_token_auth の current_user を導入するまでのダミーコード
  def current_user
    @current_user ||= User.first
  end
end
