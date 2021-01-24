require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:article1) { create(:article, user_id: user1.id) }
  let!(:article2) { create(:article, user_id: user2.id) }
  let(:relationship1) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }
  let(:relationship2) { create(:relationship, follower_id: user2.id, followed_id: user1.id) }
  let!(:boardroom1) { create(:boardroom, article_id: article1.id) }
  let!(:boardroom2) { create(:boardroom, article_id: article2.id) }
  let!(:user_boardroom1) { create(:user_boardroom, boardroom_id: boardroom1.id, user_id: user1.id) }
  let!(:user_boardroom2) { create(:user_boardroom, boardroom_id: boardroom2.id, user_id: user1.id) }
  let!(:favorite) { create(:favorite, user_id: user1.id, article_id: article1.id) }

  describe "メインメニューのテスト" do
    context "ログインユーザーの場合" do
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
          # 投稿記事/参加ボードの表示
          expect(page).to have_button article1.title
          expect(page).to have_selector 'img.thumbnail'
          expect(page).to have_link "#{boardroom1.article.title.slice(0..15)} Part.#{boardroom1.id}"
          expect(page).to have_link "#{boardroom2.article.title.slice(0..15)} Part.#{boardroom2.id}"
        end
      end

      it "プロフィールの動作確認" do
        within '.user-profile-box' do
          # 編集リンクの確認
          expect(page).to have_link nil, href: edit_user_registration_path
          # ログインユーザー以外では、メールフォームを設置
          visit user_path(user2.id)
          expect(page).to have_link nil, href: new_minimail_path(reciever_id: user2.id)
        end
      end

      it "マイ記事の動作確認", js: true do
        within '.user-articles-box' do
          # 記事を読むの確認
          find("#article-modal-button-#{article1.id}").click
          expect(page).to have_link '記事を読む', href: article_path(article1.id)
          visit user_path(user1.id)
          # 編集リンクの確認
          find("#article-modal-button-#{article1.id}").click
          expect(page).to have_link '記事を編集', href: edit_article_path(article1.id)
          visit user_path(user1.id)
          # 削除リンクの確認
          find("#article-modal-button-#{article1.id}").click
          expect do
            find('.btn-delete', text: '記事を削除').click
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content 'My Articles'
          end.to change(Article, :count).by(-1)
          expect(current_path).to eq user_path(user1.id)
        end
      end

      it "マイボードの動作確認" do
        within '.user-articles-box' do
          # ボードリンクの確認
          expect(page).to have_link "#{boardroom1.article.title.slice(0..15)} Part.#{boardroom1.id}",
                                    href: boardroom_path(boardroom1.id)
          expect(page).to have_link "#{boardroom2.article.title.slice(0..15)} Part.#{boardroom2.id}",
                                    href: boardroom_path(boardroom2.id)
        end
      end
    end

    context "他のユーザーの場合" do
      before do
        login(user1)
        visit user_path(user2.id)
      end

      it "他ユーザーのマイ記事の動作確認", js: true do
        within '.user-articles-box' do
          # 記事を読むの確認
          find("#article-modal-button-#{article2.id}").click
          expect(page).to have_link '記事を読む', href: article_path(article2.id)
          visit user_path(user2.id)
          # 編集/削除リンクがないことを確認
          find("#article-modal-button-#{article2.id}").click
          expect(page).to have_no_link '記事を編集', href: edit_article_path(article2.id)
          expect(page).to have_no_content '記事を削除'
        end
      end
    end
  end

  describe "フォロー中ユーザーのテスト" do
    before do
      login(user1)
      visit following_user_path(relationship1.follower_id)
    end

    it "フォロー中ユーザーの確認" do
      within '.follow-member-box' do
        expect(page).to have_link "#{user2.name}-#{user2.id}", href: user_path(user2.id)
      end
    end
  end

  describe "フォロワーユーザーのテスト" do
    before do
      login(user1)
      visit followers_user_path(relationship2.followed_id)
    end

    it "フォロワーユーザーの確認" do
      within '.follow-member-box' do
        expect(page).to have_link "#{user2.name}-#{user2.id}", href: user_path(user2.id)
      end
    end
  end

  describe "お気に入りのテスト" do
    before do
      login(user1)
      visit favoring_user_path(favorite.user_id)
    end

    it "お気に入りリストの確認" do
      within '.user-articles-box' do
        expect(page).to have_button article1.title
        expect(page).to have_selector 'img.thumbnail'
      end
    end
  end

  describe "編集メニューのテスト" do
    before do
      login(user1)
      visit edit_user_registration_path
    end

    it "現在のユーザー情報を表示" do
      have_field '名前', with: user1.name
      have_field 'メールアドレス', with: user1.name
      have_field '自己紹介', with: user1.name
    end

    it "更新の完了" do
      fill_in '名前', with: 'New Name'
      fill_in 'メールアドレス', with: 'New@google.com'
      fill_in '自己紹介', with: 'New Introduce.'
      fill_in '現在のパスワード', with: user1.password
      click_on "更新"
      expect(current_path).to eq user_path(user1)
      expect(page).to have_content 'New Name'
    end
  end

  describe "アカウント削除のテスト" do
    before do
      login(user1)
      visit edit_user_registration_path
    end

    it "アカウント削除の成功", js: true, retry: 3 do
      expect do
        click_link 'アカウント削除'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq root_path
      end.to change(User, :count).by(-1)
    end
  end
end
