require 'rails_helper'

RSpec.describe Room, type: :model do
  let!(:room) { create(:room) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(room).to be_valid
      end
    end

    context "登録ができないとき" do
      it "purchase_idがなければ登録できないこと" do
        room.purchase_id = nil
        room.valid?
        expect(room).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "purchaseとの関連" do
      let(:target) { :purchase }

      it "purchaseとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "messageとの関連" do
      let(:target) { :messages }

      it "messageとの関連はhas_manyであること" do
        expect(association.macro).to eq has_many
      end
    end
  end
end
