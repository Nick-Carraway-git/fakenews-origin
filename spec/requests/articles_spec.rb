require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    let(:user) { create(:user) }
    let(:article) { create(:article) }

    before do
      get article_path(article.id)
    end

    it "商品ページの表示" do
      expect(response).to have_http_status(200)
    end
  end
end
