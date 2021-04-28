require 'rails_helper'

RSpec.describe Entry, type: :model do
  let!(:entry) { create(:entry) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(entry).to be_valid
      end
    end

    context "登録ができないとき" do
      it "entryがなければ登録できないこと" do
        entry.user_id = nil
        entry.valid?
        expect(entry).to be_invalid
      end

      it "entryがなければ登録できないこと" do
        entry.dm_room_id = nil
        entry.valid?
        expect(entry).to be_invalid
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

    context "dm_roomとの関連" do
      let(:target) { :dm_room}

      it "dm_roomとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
