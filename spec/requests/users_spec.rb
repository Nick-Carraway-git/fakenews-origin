require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, introduce: 'Nice to meet you.') }

  describe "ユーザー個別ページ(users/show)のテスト" do
    before do
      get user_path(user.id)
    end

    it "リクエストの成功" do
      expect(response).to have_http_status(200)
    end

    it "ユーザー情報の表示" do
      expect(response.body).to include user.name
      expect(response.body).to include user.introduce
    end

    it "メニュータグの表示" do
      expect(response.body).to include 'メインメニュー'
      expect(response.body).to include 'フォロー中'
      expect(response.body).to include 'フォロワー'
      expect(response.body).to include 'お気に入り'
    end
  end
end
