require 'rails_helper'

RSpec.describe "Minimails", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:minimail1) { create(:minimail, reciever_id: user1.id, sender_id: user2.id) }
  let!(:minimail2) { create(:minimail, reciever_id: user2.id, sender_id: user1.id) }

  describe "ミニメールの一覧ページ(users/:id/recieved)のテスト" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get recieved_user_path(user1)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user1
        get recieved_user_path(user1)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "受信メールの表示" do
        expect(response.body).to include minimail1.title
      end
    end
  end

  describe "ミニメールの一覧ページ(users/:id/sended)のテスト" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get sended_user_path(user1)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user1
        get sended_user_path(user1)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "送信メールの表示" do
        expect(response.body).to include minimail2.title
      end
    end
  end

  describe "ミニメール個別ページ(minimails/show)のテスト" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get minimail_path(minimail1)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user1
        get minimail_path(minimail1)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "個別メールの表示" do
        expect(response.body).to include user2.name
        expect(response.body).to include minimail1.title
        expect(response.body).to include minimail1.content
      end
    end
  end

  describe "ミニメール送信ページ(minimails/new)のテスト" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get new_minimail_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済の場合" do
      before do
        sign_in user1
        get new_minimail_path(reciever_id: user2.id)
      end

      it "リクエストの成功" do
        expect(response).to have_http_status(200)
      end

      it "送受信者の名前を表示" do
        expect(response.body).to include user1.name
        expect(response.body).to include user2.name
      end
    end
  end
end
