require 'rails_helper'

RSpec.describe DmRoom, type: :model do
  let!(:dm_room) { create(:dm_room) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(dm_room).to be_valid
      end
    end

    context "登録ができないとき" do
      it "user_idがなければ登録できないこと" do
        dm_room.user_id = nil
        dm_room.valid?
        expect(dm_room).to be_invalid
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
  end
end
