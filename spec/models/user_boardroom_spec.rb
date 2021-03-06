require 'rails_helper'

RSpec.describe UserBoardroom, type: :model do
  let!(:user) { create(:user) }
  let!(:boardroom) { create(:boardroom) }
  let!(:user_boardroom) { create(:user_boardroom, user_id: user.id, boardroom_id: boardroom.id) }

  describe "UserBoardroomモデルの作成" do
    it "参加ユーザー、ボードルームがあれば有効" do
      expect(user_boardroom).to be_valid
    end

    it "参加ユーザーなしは無効" do
      user_boardroom.user_id = nil
      expect(user_boardroom).not_to be_valid
    end

    it "ボードルームなしは無効" do
      user_boardroom.boardroom_id = nil
      expect(user_boardroom).not_to be_valid
    end
  end

  describe "UserBoardroomモデルの依存性" do
    it "ユーザーが消えると中間レコードも消える" do
      expect do
        user.destroy
      end.to change(UserBoardroom, :count).by(-1)
    end

    it "ボードルーム消えると中間レコードも消える" do
      expect do
        boardroom.destroy
      end.to change(UserBoardroom, :count).by(-1)
    end
  end
end
