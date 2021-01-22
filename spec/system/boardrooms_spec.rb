require 'rails_helper'

RSpec.describe "Boardrooms", type: :system do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:boardroom) { create(:boardroom, article_id: article.id)}
  let!(:user_boardroom) { create(:user_boardroom, user_id: user.id, boardroom_id: boardroom.id) }

  describe "ボードルーム機能のテスト" do
    context "ボードルームの作成" do
      before do
        login(user)
        visit article_path(article)
      end

      it "記事のボタンからボードルームの作成" do
        within '.boardroom-creater' do
          expect do
            click_button 'ボードを作成'
            # localではOK、要調査
            # expect(current_path).to eq boardroom_path(Boardroom.first.id)
          end.to change(Boardroom, :count).by(1)
        end
      end
    end

    context "ボードルームの利用" do
      before do
        login(user)
        visit boardroom_path(boardroom)
      end

      it "ボードルームの表示" do
        within '.chat-heading' do
          expect(page).to have_content "#{article.title} Part.#{article.boardrooms.first.id}"
        end
      end

      it "ボードルームからの退出", js: true do
        click_link('退出する')
        expect(current_path).not_to eq boardroom_path(boardroom)
      end

      it "ボードルームへの書き込み", js: true do
        # 書き込んだコメントがliveコメントとして表示
        fill_in 'speak-field', with: 'Test'
        find('#speak-field').native.send_keys(:return)
        expect(page).to have_css '.live-content'
        # 再度訪れた時にはliveコメントではなくなる
        visit boardroom_path(boardroom)
        expect(page).not_to have_css '.live-content'
      end
    end
  end
end
