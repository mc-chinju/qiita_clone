require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    before { create_list(:article, 3) }

    it "記事の一覧が取得できる" do
      subject

      res = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(res.length).to eq 3
        expect(res[0].keys).to eq ["id", "title", "body", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の記事が存在する場合" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "任意の記事の値が取得できる" do
        subject

        res = JSON.parse(response.body)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(res["id"]).to eq article.id
          expect(res["title"]).to eq article.title
          expect(res["body"]).to eq article.body
          expect(res["user"]["id"]).to eq article.user.id
          expect(res["user"].keys).to eq ["id", "name", "email"]
        end
      end
    end

    context "指定した id の記事が存在しない場合" do
      let(:article_id) { 10000 }

      it "記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /articles" do
    subject { post(api_v1_articles_path, params: params) }

    let(:params) { { article: attributes_for(:article) } }

    # FIXME: devise_token_auth の導入が完了次第修正すること
    before { create(:user) }

    it "記事のレコードが作成できる" do
      aggregate_failures do
        expect { subject }.to change { Article.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(api_v1_article_path(article_id), params: params) }

    let(:params) { { article: attributes_for(:article) } }
    let(:article) { create(:article) }
    let(:article_id) { article.id }

    it "任意のユーザーのレコードを更新できる" do
      aggregate_failures do
        expect { subject }.to change { Article.find(article_id).title }.from(article.title).to(params[:article][:title]) &
                              change { Article.find(article_id).body }.from(article.body).to(params[:article][:body])
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
