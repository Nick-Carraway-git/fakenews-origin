require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Userモデルの作成" do
    context "パラメータが正常な場合" do
      it "名前、メールアドレス、パスワード、パスワード(確認用)があれば有効" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "パラメータが不正な場合(名前)" do
      it "名前なしは無効" do
        user = build(:user, name: nil)
        expect(user).not_to be_valid
      end

      it "名前が30字を超えると無効" do
        user = build(:user, name: 'a' * 35)
        expect(user).not_to be_valid
      end
    end

    context "パラメータが不正な場合(メールアドレス)" do
      it "メールアドレスなしは無効" do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end

      it "メールアドレスに@がないと無効" do
        user = build(:user, email: /\A[\w+\-.]+[a-z\d\-.]+\.[a-z]+\z/i)
        expect(user).not_to be_valid
      end

      it "メールアドレスが重複すると無効" do
        user1 = create(:user, email: 'example@xxx.co.jp')
        user2 = build(:user, email: 'example@xxx.co.jp')
        expect(user2).not_to be_valid
      end
    end

    context "パラメータが不正な場合(パスワード)" do
      it "パスワードなしは無効" do
        user = build(:user, password: nil)
        expect(user).not_to be_valid
      end

      it "パスワード6字未満は無効" do
        user = build(:user, password: 'a' * 5)
        expect(user).not_to be_valid
      end
    end

    context "パラメータが不正な場合(パスワード確認用)" do
      it "パスワード確認用なしは無効" do
        user = build(:user, password: 'abcdefg', password_confirmation: '')
        expect(user).not_to be_valid
      end

      it "パスワード確認用が一致しないと無効" do
        user = build(:user, password: 'abcdefg', password_confirmation: 'abcdeff')
        expect(user).not_to be_valid
      end
    end
  end
end
