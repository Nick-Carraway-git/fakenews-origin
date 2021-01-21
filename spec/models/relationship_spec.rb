require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "Relationshipモデルの作成" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

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
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:relationship) { user1.active_relationships.create(followed_id: user2.id) }

    it "フォロワーが消えると中間レコードも消える" do
      expect do
        user1.destroy
      end.to change(Relationship, :count).by(-1)
    end

    it "フォローされているユーザーが消えると中間レコードも消える" do
      expect do
        user2.destroy
      end.to change(Relationship, :count).by(-1)
    end
  end
end
