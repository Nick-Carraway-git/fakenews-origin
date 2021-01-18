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

    it "メインメニューの表示" do
      # プロフィールの表示
      within '.user-profile-box' do
        expect(page).to have_selector 'img.avator'
        expect(page).to have_selector 'h3', text: user1.name
        expect(page).to have_selector 'div.introduce', text: user1.introduce
        expect(page).to have_selector '#articles', text: user1.articles.count
        expect(page).to have_selector '#following', text: user1.following.count
        expect(page).to have_selector '#followers', text: user1.followers.count
      end

      within '.user-articles-box' do
        # 投稿記事の表示
        expect(page).to have_button article1.title
        expect(page).to have_selector 'img.thumbnail'
        # ボードの表示
        expect(page).to have_link "#{boardroom1.article.title.slice(0..15)} Part.#{boardroom1.id}"
        expect(page).to have_link "#{boardroom2.article.title.slice(0..15)} Part.#{boardroom2.id}"
      end
    end

    it "メインメニューの動作確認" , js: true do
      # プロフィール部分の動作確認
      within '.user-profile-box' do
        # 編集リンクの確認
        expect(page).to have_link nil, href: edit_user_registration_path
        # ログインユーザー以外では、メールフォームを設置
        visit user_path(user2.id)
        expect(page).to have_link nil, href: new_minimail_path(reciever_id: user2.id)
      end

      visit user_path(user1.id)
      ## メニュー部分の動作確認
      within '.user-articles-box' do
        # 編集リンクの確認
        find("#article-modal-button-#{article1.id}").click
        expect(page).to have_link '記事を読む', href: article_path(article1.id)
      end
    end
  end
end

# find('.profile-edit-button').click
