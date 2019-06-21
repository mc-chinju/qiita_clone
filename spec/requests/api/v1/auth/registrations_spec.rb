require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "必要なパラメータを送信したとき" do
      let(:params) { attributes_for(:user).slice(:name, :email, :password) }

      it "ユーザーが作成される" do
        aggregate_failures do
          expect { subject }.to change { User.count }.by(1)

          data = JSON.parse(response.body)["data"]

          expect(response).to have_http_status(:ok)
          expect(data["provider"]).to eq "email"
          expect(data["name"]).to eq params[:name]
          expect(data["email"]).to eq params[:email]
        end
      end
    end

    context "送信したパラメータに不足があったとき(emailを送信していない)" do
      let(:params) { attributes_for(:user).slice(:name, :password) }

      it "ユーザーは作成されず、422 Error が発生する" do
        aggregate_failures do
          # TODO: 422 Error が発生したときの Error handling
          expect { subject }.to change { User.count }.by(0)

          res = JSON.parse(response.body)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(res["errors"]["email"]).to match_array ["can't be blank"]
        end
      end
    end

    context "すでに同一のメールアドレスのユーザー登録があったとき" do
      before { create(:user, email: email) }

      let(:email) { Faker::Internet.email }
      let(:params) { attributes_for(:user, email: email).slice(:name, :email, :password) }

      it "ユーザーは作成されず、422 Error が発生する" do
        aggregate_failures do
          # TODO: 422 Error が発生したときの Error handling
          expect { subject }.to change { User.count }.by(0)

          res = JSON.parse(response.body)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(res["errors"]["email"]).to match_array ["has already been taken"]
        end
      end
    end
  end
end
