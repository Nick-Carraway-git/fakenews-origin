require 'rails_helper'

RSpec.describe "Minimails", type: :system do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe "ミニメール作成のテスト" do
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
        expect(current_path).to eq root_path
        visit sended_user_path(user1)
        expect(page).to have_content 'Hi Boy.'
      end.to change(Minimail, :count).by(1)
    end
  end

  describe "ミニメール削除のテスト" do
    before do

    end

    it "メール送信の成功" do
      
    end
  end
end
