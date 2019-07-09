require "rails_helper"

RSpec.describe "Current::Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }

    let!(:article1) { create(:article, :published, user: current_user, created_at: 10.days.ago, updated_at: 1.day.ago) }
    let!(:article2) { create(:article, :published, user: current_user, created_at: 3.days.ago, updated_at: 2.days.ago) }

    before do
      create(:article, :draft, user: current_user)
      create(:article, :published)
    end

    it "自分が書いた公開記事の一覧が取得できる" do
      subject

      res = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(res.length).to eq 2
        expect(res.map {|d| d["id"] }).to eq [article2.id, article1.id]
        expect(res[0].keys).to eq ["id", "title", "created_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end
  end
end
