require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:relationship) { user3.active_relationships.create(followed_id: user4.id) }

  describe "Relationshipモデルの作成" do
    it "フォローするユーザー、フォローされるユーザーがあれば有効" do
      relationship = user1.active_relationships.build(followed_id: user2.id)
      expect(relationship).to be_valid
    end

    it "フォロワーなしは無効" do
      relationship = user1.passive_relationships.build(follower_id: nil)
      expect(relationship).not_to be_valid
    end

    it "フォロー対象のユーザーなしは無効" do
      relationship = user1.active_relationships.build(followed_id: nil)
      expect(relationship).not_to be_valid
    end
  end

  describe "Relationshipモデルの依存性" do
    it "フォロワーが消えると中間レコードも消える" do
      expect do
        user3.destroy
      end.to change(Relationship, :count).by(-1)
    end

    it "フォローされているユーザーが消えると中間レコードも消える" do
      expect do
        user4.destroy
      end.to change(Relationship, :count).by(-1)
    end
  end
end
