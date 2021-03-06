require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, :published, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, :published, updated_at: 2.days.ago) }
    let!(:article3) { create(:article, :published) }

    before { create(:article, :draft) }

    it "公開済みの記事の一覧が取得できる(更新順)" do
      subject

      res = JSON.parse(response.body)

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(res.length).to eq 3
        expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
        expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の記事が存在し" do
      let(:article_id) { article.id }

      context "対象の記事が公開中であるとき" do
        let(:article) { create(:article, :published) }

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

      context "対象の記事が下書き状態であるとき" do
        let(:article) { create(:article, :draft) }

        it "記事が見つからない" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
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
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }

    context "公開指定で記事を作成するとき" do
      let(:params) { { article: attributes_for(:article, :published) } }

      it "公開記事が作成できる" do
        aggregate_failures do
          expect { subject }.to change { Article.count }.by(1)
          res = JSON.parse(response.body)
          expect(res["status"]).to eq "published"
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "下書き指定で記事を作成するとき" do
      let(:params) { { article: attributes_for(:article, :draft) } }

      it "下書き記事が作成できる" do
        aggregate_failures do
          expect { subject }.to change { Article.count }.by(1)
          res = JSON.parse(response.body)
          expect(res["status"]).to eq "draft"
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "でたらめな指定で記事を作成するとき" do
      let(:params) { { article: attributes_for(:article, status: :foo) } }

      it "Argumennt Error する" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:params) { { article: attributes_for(:article, :published) } }
    let(:headers) { authentication_headers_for(current_user) }

    context "自分が所持している記事のレコードを更新しようとするとき" do
      let!(:article) { create(:article, :draft, user: current_user) }

      it "記事を更新できる" do
        aggregate_failures do
          expect { subject }.to change { Article.find(article.id).title }.from(article.title).to(params[:article][:title]) &
                                change { Article.find(article.id).body }.from(article.body).to(params[:article][:body]) &
                                change { Article.find(article.id).status }.from(article.status).to(params[:article][:status].to_s)
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
    subject { delete(api_v1_article_path(article_id), headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { authentication_headers_for(current_user) }
    let(:article_id) { article.id }

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
