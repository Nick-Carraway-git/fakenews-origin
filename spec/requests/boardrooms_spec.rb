require 'rails_helper'

RSpec.describe "Boardrooms", type: :request do
  let!(:user) { create(:user) }
  let!(:boardroom) { create(:boardroom) }
  let!(:chat) { create(:chat, user_id: user.id, boardroom_id: boardroom.id) }

  describe "ボードルームの一覧ページ(boardrooms/show)のテスト" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get boardroom_path(boardroom)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user
        get boardroom_path(boardroom)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "チャットの表示" do
        expect(response.body).to include chat.message
      end
    end
  end
end
