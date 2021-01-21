require 'rails_helper'

RSpec.describe Minimail, type: :model do
  describe "Minimailモデルの作成" do
    it "送信者、受信者、件名、本文があれば有効" do
      minimail = build(:minimail)
      expect(minimail).to be_valid
    end

    it "送信者なしは無効" do
      minimail = build(:minimail, sender_id: nil)
      expect(minimail).not_to be_valid
    end

    it "受信者なしは無効" do
      minimail = build(:minimail, reciever_id: nil)
      expect(minimail).not_to be_valid
    end

    it "タイトルなしは無効" do
      minimail = build(:minimail, title: nil)
      expect(minimail).not_to be_valid
    end

    it "タイトルが60字以上は無効" do
      minimail = build(:minimail, title: 'a' * 70)
      expect(minimail).not_to be_valid
    end

    it "本文なしは無効" do
      minimail = build(:minimail, content: nil)
      expect(minimail).not_to be_valid
    end

    it "本文が500字以上は無効" do
      minimail = build(:minimail, title: 'a' * 520)
      expect(minimail).not_to be_valid
    end
  end

  describe "Minimailモデルの依存性" do
    it "送信者、受信者、件名、本文があれば有効" do
      minimail = build(:minimail)
      expect(minimail).to be_valid
    end

    it "送信者なしは無効" do
      minimail = build(:minimail, sender_id: nil)
      expect(minimail).not_to be_valid
    end
  end
end
