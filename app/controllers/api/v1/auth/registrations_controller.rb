class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # MEMO: HTTP Client 経由で操作する場合にコメントインする
  # protect_from_forgery with: :null_session

  private

    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.permit(:name, :email)
    end
end
