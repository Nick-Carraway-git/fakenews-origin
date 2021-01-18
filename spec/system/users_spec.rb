require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:article1) { create(:article, user_id: user1.id) }
  let!(:article2) { create(:article, user_id: user2.id) }
  let(:relationship1) { create(:relationship, follower_id: user1.id,
                                              followed_id: user2.id) }
  let(:relationship2) { create(:relationship, follower_id: user2.id,
                                              followed_id: user1.id) }
  let!(:boardroom1) { create(:boardroom, article_id: article1.id) }
  let!(:boardroom2) { create(:boardroom, article_id: article2.id) }
  let!(:user_boardroom1) { create(:user_boardroom, boardroom_id: boardroom1.id, user_id: user1.id) }
  let!(:user_boardroom2) { create(:user_boardroom, boardroom_id: boardroom2.id, user_id: user1.id) }


  describe "メインメニューのテスト" do
    before do
      login(user1)
      visit user_path(user1.id)
    end

    it "メインメニューの表示", js: true do
      # プロフィールの表示
      within '.user-profile-box' do
        expect(page).to have_selector 'img.avator'
        expect(page).to have_selector 'h3', text: user1.name
        expect(page).to have_selector 'div.introduce', text: user1.introduce
        expect(page).to have_selector '#articles', text: user1.articles.count
        expect(page).to have_selector '#following', text: user1.following.count
        expect(page).to have_selector '#followers', text: user1.followers.count
      end

      # 投稿記事の表示
      within '.user-article-box' do
        expect(page).to have_button "#article-modal-button-#{article1.id}"
        find('.modal-button').hover
        expect(page).to have_content article1.title
      end
    end
  end
end

# find('.profile-edit-button').click
