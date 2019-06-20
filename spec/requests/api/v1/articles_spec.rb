require "rails_helper"

# FIXME: devise_token_auth 導入までの一時的なコードなため許容
# rubocop:disable RSpec/AnyInstance

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
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    it "記事のレコードが作成できる" do
      aggregate_failures do
        expect { subject }.to change { Article.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params) }

    let(:params) { { article: attributes_for(:article) } }
    # FIXME: devise_token_auth の導入が完了次第修正すること
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    context "自分が所持している記事のレコードを更新しようとするとき" do
      let!(:article) { create(:article, user: current_user) }

      it "記事を更新できる" do
        aggregate_failures do
          expect { subject }.to change { Article.find(article.id).title }.from(article.title).to(params[:article][:title]) &
                                change { Article.find(article.id).body }.from(article.body).to(params[:article][:body])
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "自分が所持していない記事のレコードを更新しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "記事が見つからない(更新できない)" do
        aggregate_failures do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                                change { Article.count }.by(0)
        end
      end
    end
  end

  describe "DELETE /articles/:id" do
    subject { delete(api_v1_article_path(article_id)) }

    let(:article_id) { article.id }
    # FIXME: devise_token_auth の導入が完了次第修正すること
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    context "自分が所持している記事のレコードを削除しようとするとき" do
      let!(:article) { create(:article, user: current_user) }

      it "記事を削除できる" do
        expect { subject }.to change { Article.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "他人が所持している記事のレコードを削除しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "記事が見つからない(削除できない)" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                              change { Article.count }.by(0)
      end
    end
  end
end

# rubocop:enable RSpec/AnyInstance
