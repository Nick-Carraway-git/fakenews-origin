require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe "記事詳細ページのテスト" do
    let(:user) { create(:user) }
    let(:article1) { create(:article) }
    let(:article2) { create(:article) }
    let!(:category1) { create(:category) }
    let!(:category2) { create(:category) }
    let!(:article_category1) { create(:article_category, article_id: article1.id, category_id: category1.id) }
    let!(:article_category2) { create(:article_category, article_id: article2.id, category_id: category2.id) }

    before do
      login(user)
      visit article_path(article1.id)
    end

    it "商品詳細ページの表示" do
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
  end
end
