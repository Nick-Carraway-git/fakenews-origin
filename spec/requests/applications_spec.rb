require 'rails_helper'

RSpec.describe "Applications", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user_id: user.id) }

  describe "ヘッダー(shared/header)のテスト" do
    context "ログインしていない場合" do
      before do
        get root_path
      end

      it "ヘッダーの表示" do
        # ヘッダーの表示
        expect(response.body).to include '記事を読む'
        expect(response.body).to include '新規登録'
        expect(response.body).to include 'ログイン'
        # 背景の表示
        expect(response.body).to include 'サービス概要'
        expect(response.body).to include 'ゲストログイン'
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        get root_path
      end

      it "ヘッダーの表示" do
        # ヘッダーの表示
        expect(response.body).to include '<i class="fas fa-book-reader header-icon"></i>'
        expect(response.body).to include '<i class="fas fa-search header-icon"></i>'
        expect(response.body).to include '<i class="fas fa-feather-alt header-icon"></i>'
        expect(response.body).to include '<i class="fas fa-user header-icon"></i>'
        expect(response.body).to include '<i class="far fa-envelope header-icon"></i>'
        # 背景の表示
        expect(response.body).to include 'サービス概要'
      end
    end
  end
end
