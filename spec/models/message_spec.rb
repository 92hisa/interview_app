require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message) { create(:message) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(message).to be_valid
      end
    end

    context "登録ができないとき" do
      it "user_idがなければ登録できないこと" do
        message.user_id = nil
        message.valid?
        expect(message).to be_invalid
      end

      it "room_idがなければ登録できないこと" do
        message.room_id = nil
        message.valid?
        expect(message).to be_invalid
      end

      it "messageがなければ登録できないこと" do
        message.message = nil
        message.valid?
        expect(message).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "userとの関連" do
      let(:target) { :user }

      it "userとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "notificationとの関連" do
      let(:target) { :notifications }

      it "notificationとの関連はbelongs_toであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
