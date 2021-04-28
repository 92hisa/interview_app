require 'rails_helper'

RSpec.describe PostCategoryRelation, type: :model do
  let!(:post_category_relation) { create(:post_category_relation) }


  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(post_category_relation).to be_valid
      end
    end

    context "登録ができないとき" do
      it "category_idがなければ登録できないこと" do
        post_category_relation.category_id = nil
        post_category_relation.valid?
        expect(post_category_relation).to be_invalid
      end

      it "post_idがなければ登録できないこと" do
        post_category_relation.post_id = nil
        post_category_relation.valid?
        expect(post_category_relation).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "categoryとの関連" do
      let(:target) { :category }

      it "categoryとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "postとの関連" do
      let(:target) { :post }

      it "postとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
