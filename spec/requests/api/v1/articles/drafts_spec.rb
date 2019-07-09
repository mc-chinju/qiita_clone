require "rails_helper"

RSpec.describe "Articles::Drafts", type: :request do
  describe "GET /api/v1/articles/drafts" do
    subject { get(api_v1_articles_drafts_path, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }

    let!(:article1) { create(:article, :draft, user: current_user) }
    let!(:article2) { create(:article, :draft) }

    it "自分が書いた下書き記事の一覧が取得できる" do
      subject

      res = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(res.length).to eq 1
        expect(res[0]["id"]).to eq article1.id
        expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end
  end

  describe "GET /articles/drafts/:id" do
    subject { get(api_v1_articles_draft_path(article_id), headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }

    context "指定した id の記事が存在し" do
      let(:article_id) { article.id }

      context "対象の記事が自身の下書きであるとき" do
        let(:article) { create(:article, :draft, user: current_user) }

        it "記事のデータを取得できる" do
          subject

          res = JSON.parse(response.body)

          aggregate_failures do
            expect(response).to have_http_status(:ok)
            expect(res["id"]).to eq article.id
            expect(res["title"]).to eq article.title
            expect(res["body"]).to eq article.body
            expect(res["status"]).to eq article.status
            expect(res["updated_at"]).to be_present
            expect(res["user"]["id"]).to eq article.user.id
            expect(res["user"].keys).to eq ["id", "name", "email"]
          end
        end
      end

      context "対象の記事が他のユーザーの下書きであるとき" do
        let(:article) { create(:article, :draft) }

        it "記事が見つからない" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
