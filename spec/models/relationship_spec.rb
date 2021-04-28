require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }
  describe '#create' do
    context "保存できる場合" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(relationship).to be_valid
      end
    end

    context "保存できない場合" do
      it "follow_idがnilの場合は保存できない" do
        relationship.follow_id = nil
        relationship.valid?
        expect(relationship).to be_invalid
      end

      it "user_idがnilの場合は保存できない" do
        relationship.user_id = nil
        relationship.valid?
        expect(relationship).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
   let(:association) do
     described_class.reflect_on_association(target)
   end

   context "仮想モデルfollowとのアソシエーション" do
     let(:target) { :follow }

     it "followとの関連付けはbelongs_toであること" do
       expect(association.macro).to  eq :belongs_to
     end
   end

   context "userとの関連" do
     let(:target) { :user }

     it "userとの関連はbelongs_toであること" do
       expect(association.macro).to eq :belongs_to
     end
   end
 end
end
