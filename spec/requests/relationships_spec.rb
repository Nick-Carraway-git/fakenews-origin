require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:relationship1) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }
  let(:relationship2) { create(:relationship, follower_id: user2.id, followed_id: user1.id) }

  describe "ユーザー個別ページ(users/:id/following)のテスト" do
    before do
      sign_in user1
      get following_user_path(relationship1.follower_id)
    end

    it "リクエストの成功" do
      expect(response).to have_http_status(200)
    end

    it "フォロー中のユーザーを表示" do
      expect(response.body).to include user2.name
    end
  end

  describe "ユーザー個別ページ(users/:id/followed)のテスト" do
    before do
      sign_in user1
      get followers_user_path(relationship1.followed_id)
    end

    it "リクエストの成功" do
      expect(response).to have_http_status(200)
    end

    it "フォローされているユーザーを表示" do
      expect(response.body).to include user2.name
    end
  end
end
