require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    it "works! (now write some real specs)" do
      get api_v1_articles_path
      expect(response).to have_http_status(:ok)
    end
  end
end
