require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:relationship) { user2.active_relationships.create(followed_id: user1.id) }

  describe "フォロー機能のテスト" do
    before do
      login(user1)
      visit user_path(user2.id)
    end

    it "フォローの成功", js: true do
      expect do
        expect(page).to have_button '  Follow  '
        find('#follow-commit').click
        expect(current_path).to eq user_path(user2.id)
        expect(page).to have_button 'Unfollow'
      end.to change(Relationship, :count).by(1)
    end
  end

  describe "フォロー機能のテスト" do
    before do
      login(user2)
      visit user_path(user1.id)
    end

    it "フォロー解除の成功", js: true do
      expect do
        expect(page).to have_button 'Unfollow'
        find('#unfollow-commit').click
        expect(current_path).to eq user_path(user1.id)
        expect(page).to have_button '  Follow  '
      end.to change(Relationship, :count).by(-1)
    end
  end
end
