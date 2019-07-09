require "rails_helper"

RSpec.describe "Current::Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }

    let!(:article) { create(:article, :published, user: current_user) }

    before do
      create(:article, :draft, user: current_user)
      create(:article, :published)
    end

    it "自分が書いた公開記事の一覧が取得できる" do
      subject

      res = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(res.length).to eq 1
        expect(res[0]["id"]).to eq article.id
        expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end
  end
end
