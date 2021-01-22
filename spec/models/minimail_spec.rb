require 'rails_helper'

RSpec.describe Minimail, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:minimail1) { user1.send_minimails.build(reciever_id: user2.id,
                                               title: 'Title1', content: 'Content1') }
  let!(:minimail2) { user1.recieve_minimails.build(sender_id: user2.id,
                                               title: 'Title2', content: 'Content2') }

  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:minimail3) { user3.send_minimails.create(reciever_id: user4.id,
                                                title: 'Title1', content: 'Content1') }
  describe "Minimailモデルの作成" do
    context "パラメータが有効な場合" do
      it "送信者、受信者、件名、本文があれば有効" do
        expect(minimail1).to be_valid
        expect(minimail2).to be_valid
      end
    end

    context "パラメータが不正な場合" do
      it "送信者なしは無効" do
        minimail2.sender_id = nil
        expect(minimail2).not_to be_valid
      end

      it "受信者なしは無効" do
        minimail1.reciever_id = nil
        expect(minimail1).not_to be_valid
      end

      it "タイトルなしは無効" do
        minimail1.title = ''
        expect(minimail1).not_to be_valid
      end

      it "タイトルが60字以上は無効" do
        minimail1.title = 'a' * 70
        expect(minimail1).not_to be_valid
      end

      it "本文なしは無効" do
        minimail1.content = ''
        expect(minimail1).not_to be_valid
      end

      it "本文が500字以上は無効" do
        minimail1.content = 'a' * 520
        expect(minimail1).not_to be_valid
      end
    end
  end

  describe "Minimailモデルの依存性" do
    it "送信者が削除されると、メールも削除" do
      expect do
        user3.destroy
      end.to change(Minimail, :count).by(-1)
    end

    it "受信者が削除されると、メールも削除" do
      expect do
        user4.destroy
      end.to change(Minimail, :count).by(-1)
    end
  end
end
