module Api::V1
  class ArticlesController < BaseApiController
    before_action :set_article, only: [:show, :update, :destroy]

    def index
      articles = Article.all
      render json: articles
    end

    def show
      render json: @article
    end

    def create
      article = Article.create!(article_params)
      render json: article
    end

    def update
      @article.update!(article_params)
      render json: @article
    end

    def destroy
      @article.destroy!
      render json: @article
    end

    private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :body)
      end
  end
end
