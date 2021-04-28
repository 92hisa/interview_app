require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user) { create(:user) }
  let!(:purchase) { create(:purchase) }
  let!(:review) { create(:review) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(review).to be_valid
      end
    end

    context "登録ができないとき" do
      it "scoreがなければ登録できないこと" do
        review.score = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "contentがなければ登録できないこと" do
        review.content = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "saler_idがなければ登録できないこと" do
        review.saler_id = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "buyer_idがなければ登録できないこと" do
        review.buyer_id = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "user_idがなければ登録できないこと" do
        review.buyer_id = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "purchase_idがなければ登録できないこと" do
        review.buyer_id = nil
        review.valid?
        expect(review).to be_invalid
      end

      it "contentが300文字より多い場合は登録できないこと" do
        review = build(:review, content: "a" * 301)
        review.valid?
        expect(review).to be_invalid
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

    context "purchaseとの関連" do
      let(:target) { :purchase }

      it "purchaseとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "salerとの関連" do
      let(:target) { :saler }

      it "salerとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "buyerとの関連" do
      let(:target) { :buyer }

      it "buyerとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
