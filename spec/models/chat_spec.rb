require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "Chatモデルの作成" do
    it "ユーザー、ボードルーム、メッセージがあれば有効" do
      chat = build(:chat)
      expect(chat).to be_valid
    end

    it "ユーザーなしは無効" do
      chat = build(:chat, user_id: nil)
      expect(chat).not_to be_valid
    end

    it "ボードルームなしは無効" do
      chat = build(:chat, boardroom_id: nil)
      expect(chat).not_to be_valid
    end

    it "メッセージなしは無効" do
      chat = build(:chat, message: nil)
      expect(chat).not_to be_valid
    end

    it "メッセージが100字以上は無効" do
      chat = build(:chat, message: 'a' * 120)
      expect(chat).not_to be_valid
    end
  end
end
