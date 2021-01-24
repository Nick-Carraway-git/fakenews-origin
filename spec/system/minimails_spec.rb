require 'rails_helper'

RSpec.describe "Minimails", type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:minimail) do
    user1.send_minimails.create(reciever_id: user2.id, title: 'Title1', content: 'Content1')
  end

  describe "ミニメール作成テスト" do
    before do
      login(user1)
      visit user_path(user2)
    end

    it "メール送信の成功" do
      expect do
        find('#profile-sender').click
        expect(page).to have_current_path new_minimail_path, ignore_query: true
        fill_in 'minimail_title', with: 'Hi Boy.'
        fill_in 'minimail_content', with: 'How are you?'
        click_on('commit')
        # 送信トレイに送ったメールが含まれる
        expect(current_path).to eq sended_user_path(user1)
        expect(page).to have_content 'Hi Boy.'
      end.to change(Minimail, :count).by(1)
    end
  end

  describe "ミニメール受信テスト" do
    before do
      login(user2)
      visit recieved_user_path(user2)
    end

    it "メール受信の成功" do
      expect(page).to have_content minimail.title
    end

    it "既読メールがチェックされる" do
      expect(page).to have_css '.mail-title'
      expect(page).to have_no_css '.checked-mail-title'
      click_link('Title1')
      visit recieved_user_path(user2)
      expect(page).to have_css '.checked-mail-title'
    end

    it "メール返信機能の確認" do
      expect do
        visit minimail_path(minimail)
        # メール詳細の表示
        expect(page).to have_content user1.name
        expect(page).to have_content minimail.content
        find('#reply-mark').click
        # 返信メールの作成画面
        expect(page).to have_content "送信者: #{user2.name}"
        expect(page).to have_content "受信者: #{user1.name}"
        fill_in 'minimail_title', with: 'Hi Girl.'
        fill_in 'minimail_content', with: 'How are you today?'
        click_on('commit')
        # 送信トレイに返信したメールが含まれる
        expect(current_path).to eq sended_user_path(user2)
        expect(page).to have_content 'Hi Girl.'
      end.to change(Minimail, :count).by(1)
    end
  end
end
