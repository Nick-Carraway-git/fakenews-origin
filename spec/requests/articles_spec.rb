require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) { create(:user) }
  let!(:article1) { create(:article, user_id: user.id) }
  let!(:article2) { create(:article) }

  describe "記事一覧ページ(articles/index)のテスト" do
    before do
      get articles_path
    end

    it "リクエストの成功" do
      expect(response).to have_http_status(200)
    end

    it "記事一覧の表示" do
      expect(response.body).to include article1.title
      expect(response.body).to include article2.title
    end
  end

  describe "記事個別ページ(articles/show)のテスト" do
    before do
      get article_path(article1.id)
    end

    context "ログインしていない場合" do
      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "タイトルの表示" do
        expect(response.body).to include article1.title
      end

      it "本文の表示" do
        expect(response.body).to include article1.content
      end

      it "画像説明文の表示" do
        expect(response.body).to include article1.image_description
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user
        get article_path(article1.id)
      end

      it "ボードボタン・お気に入り登録の表示" do
        expect(response.body).to include "ボードを作成"
        expect(response.body).to include "最新のボード"
        expect(response.body).to include "お気に入りに登録"
      end
    end
  end

  describe "記事作成ページ(articles/new)のテスト" do
    context "ログインしていない場合" do
      before do
        get new_article_path
      end

      it "ログインページにリダイレクト" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user
        get new_article_path
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "記事編集ページ(articles/edit)のテスト" do
    context "ログインしていない場合" do
      before do
        get edit_article_path(article1.id)
      end

      it "ログインページにリダイレクト" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user
        get edit_article_path(article1.id)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
