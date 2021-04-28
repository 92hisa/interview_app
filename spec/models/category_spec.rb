require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { create(:category) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(category).to be_valid
      end
    end

    context "登録ができないとき" do
      it "nameがなければ登録できないこと" do
        category.name = nil
        category.valid?
        expect(category).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "post_category_relationとの関連" do
      let(:target) { :post_category_relations }

      it "post_category_relationsとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "postとの関連" do
      let(:target) { :posts }

      it "postとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
