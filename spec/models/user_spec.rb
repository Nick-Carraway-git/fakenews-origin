require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Userモデルの作成" do
    it "名前、メールアドレス、パスワード、パスワード(確認用)があれば有効" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "名前なしは無効" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "名前が30字を超えると無効" do
      user = build(:user, name: 'a' * 35)
      expect(article).not_to be_valid
    end

    it "メールアドレスなしは無効" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "メールアドレスに@がないと無効" do
      user = build(:user, email: /\A[\w+\-.]+[a-z\d\-.]+\.[a-z]+\z/i)
      expect(user).not_to be_valid
    end

    it "メールアドレスが重複すると無効" do
      user = build(:user, email: /\A[\w+\-.]+[a-z\d\-.]+\.[a-z]+\z/i)
      expect(user).not_to be_valid
    end

    it "パスワードなしは無効" do
      user = build(:user, image_description: nil)
      expect(user).not_to be_valid
    end

    it "パスワード6字未満は無効" do
      user = build(:user, image_description: 'a' * 80)
      expect(user).not_to be_valid
    end

    it "パスワード確認用なしは無効" do
      user = build(:user, user_id: nil)
      expect(user).not_to be_valid
    end
  end
end
