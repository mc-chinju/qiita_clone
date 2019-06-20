class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  # MEMO: HTTP Client 経由で操作する場合にコメントインする
  # protect_from_forgery with: :null_session
end
