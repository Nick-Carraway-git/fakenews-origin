require 'rails_helper'

RSpec.describe Boardroom, type: :model do
  let!(:article) { create(:article) }

  describe "Boardroomモデルの作成" do
    it "親記事があれば有効" do
      boardroom = build(:boardroom, article_id: article.id)
      expect(boardroom).to be_valid
    end

    it "親記事なしは無効" do
      boardroom = build(:boardroom, article_id: nil)
      expect(boardroom).not_to be_valid
    end
  end

  describe "Boardroomの依存性" do
    let!(:boardroom) { create(:boardroom, article_id: article.id) }

    it "親記事が消えるとボードルームも消える" do
      expect do
        article.destroy
      end.to change(Boardroom, :count).by(-1)
    end
  end
end
