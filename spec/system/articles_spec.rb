require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  let(:user) { create(:user) }
  let(:article1) { create(:article) }
  let(:article2) { create(:article) }
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:article_category1) { create(:article_category, article_id: article1.id, category_id: category1.id) }
  let!(:article_category2) { create(:article_category, article_id: article2.id, category_id: category2.id) }
  let!(:boardroom) { create(:boardroom, article_id: article1.id) }

  describe "記事詳細ページのテスト" do
    before do
      login(user)
      visit article_path(article1.id)
    end

    it "記事詳細ページの表示" do
      # 記事見出しの表示
      within '.article-heading-box' do
        expect(page).to have_selector "div.category-tag", text: category1.name
        expect(page).to have_selector "h2", text: article1.title
        expect(page).to have_selector "img"
        expect(page).to have_selector "p", text: article1.image_description
      end

      # ボード作成・最新ボードリンクの表示
      within '.boardroom-creater' do
        expect(page).to have_button 'ボードを作成'
      end
      within '.now-boardroom-shower' do
        expect(page).to have_button '最新のボード'
      end

      # 記事本文の表示
      within '.article-body-box' do
        expect(page).to have_content article1.content
      end
    end

    it "ページ内UIの確認" do
      # 最新のボードドロップダウンの動作
      within '.now-boardroom-shower' do
        find('.dropdown-toggle').click
        expect(page).to have_content "ボード1"
      end

      # ボード作成の動作
      within '.boardroom-creater' do
        expect do
          click_button 'ボードを作成'
          # localではOK、要調査
          # expect(current_path).to eq boardroom_path(Boardroom.first.id)
        end.to change(Boardroom, :count).by(1)
      end

      visit article_path(article1.id)

      # お気に入りボタンの動作
      within '#favor_form' do
        expect do
          click_button 'お気に入りに登録'
        end.to change(user.favorites, :count).by(1)

        expect do
          click_button 'お気に入りを解除'
        end.to change(user.favorites, :count).by(-1)
      end
    end
  end

  describe "記事一覧ページのテスト" do
    before do
      login(user)
      visit articles_path
    end

    it "記事一覧ページの表示" do
      # expect(page).to have_content article1.categories.map(&:name)
      expect(page).to have_content category1.name
      expect(page).to have_content article1.title
      expect(page).to have_content category2.name
      expect(page).to have_content article2.title
      expect(page).to have_link "picture-decoration-#{article2.id}",
                                href: article_path(article2.id)
    end
  end

  describe "記事投稿のテスト", js: true do
    before do
      login(user)
      visit new_article_path
    end

    context "入力が正常の場合" do
      it "記事投稿の成功" do
        expect do
          check category1.name
          fill_in 'title-box', with: 'Test Title'
          fill_in 'content-box', with: 'Test content.'
          fill_in 'image_description-box', with: 'Test picture desu.'
          attach_file 'image_upload-button', "#{Rails.root}/spec/fixtures/sample.jpg"
          click_on "投稿"
        end.to change(Article, :count).by(1)
        expect(page).to have_content 'Test Title'
      end
    end

    context "入力が不正な場合" do
      it "記事投稿の失敗" do
        expect do
          fill_in 'title-box', with: ''
          fill_in 'content-box', with: 'Test content.'
          fill_in 'image_description-box', with: 'Test picture desu.'
          click_on "投稿"
        end.to change(Article, :count).by(0)
        expect(current_path).to eq new_article_path
      end
    end
  end
end
