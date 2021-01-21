require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "Chatモデルの作成" do
    let(:chat) { create(:chat) }

    context "パラメータが正常な場合" do
      it "ユーザー、ボードルーム、メッセージがあれば有効" do
        expect(chat).to be_valid
      end
    end

    context "パラメータが不正な場合" do
      it "ユーザーなしは無効" do
        chat.user_id = nil
        expect(chat).not_to be_valid
      end

      it "ボードルームなしは無効" do
        chat.boardroom_id = nil
        expect(chat).not_to be_valid
      end

      it "メッセージなしは無効" do
        chat.message = nil
        expect(chat).not_to be_valid
      end

      it "メッセージが100字以上は無効" do
        chat.message = 'a' * 120
        expect(chat).not_to be_valid
      end
    end
  end

  describe "Chatモデルの依存性" do
    let!(:user) { create(:user) }
    let!(:boardroom) { create(:boardroom) }
    let!(:chat1) { create(:chat, user_id: user.id, boardroom_id: boardroom.id) }

    it "ユーザー、ボードルーム、メッセージがあれば有効" do
      expect do
        user.destroy
      end.to change(Chat, :count).by(-1)
    end

    it "ユーザーなしは無効" do
      expect do
        boardroom.destroy
      end.to change(Chat, :count).by(-1)
    end
  end
end
