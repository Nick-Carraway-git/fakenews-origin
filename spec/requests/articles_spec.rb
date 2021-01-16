require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "記事個別ページ(articles/show)のテスト" do
    let(:user) { create(:user) }
    let(:article) { create(:article) }

    before do
      sign_in user
      get article_path(article.id)
    end

    it "リクエストの成功" do
      expect(response).to have_http_status(200)
    end

    it "タイトルの表示" do
      expect(response.body).to include article.title
    end

    it "本文の表示" do
      expect(response.body).to include article.content
    end

    it "画像説明文の表示" do
      expect(response.body).to include article.image_description
    end

    it "ボードボタン・お気に入り登録の表示" do
      expect(response.body).to include "ボードを作成"
      expect(response.body).to include "最新のボード"
      expect(response.body).to include "お気に入りに登録"
    end
  end
end
