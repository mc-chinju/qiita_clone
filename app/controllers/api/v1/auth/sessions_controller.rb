class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  protect_from_forgery with: :null_session
end
