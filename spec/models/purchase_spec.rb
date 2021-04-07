require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let!(:saler) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:buyer) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }
  let!(:first_post) { create(:post, user: saler) }
  let!(:purchase) { create(:purchase, user_id: buyer.id, post_id: first_post.id, saler_id: saler.id, buyer_id: buyer.id) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(purchase).to be_valid
      end
    end

    context "登録ができないとき" do
      it "user_idがなければ登録できないこと" do
        purchase.user_id = nil
        purchase.valid?
        expect(purchase).to be_invalid
      end

      it "buyer_idがなければ登録できないこと" do
        purchase.buyer_id = nil
        purchase.valid?
        expect(purchase).to be_invalid
      end

      it "post_idがなければ登録できないこと" do
        purchase.post_id = nil
        purchase.valid?
        expect(purchase).to be_invalid
      end

      it "saler_idがなければ登録できないこと" do
        purchase.saler_id = nil
        purchase.valid?
        expect(purchase).to be_invalid
      end
    end
  end

  describe "関連付けテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "postとの関連" do
      let(:target) { :post }

      it "postとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "userとの関連" do
      let(:target) { :user }

      it "userとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "roomとの関連" do
      let(:target) { :room }

      it "roomとの関連はhas_oneであること" do
        expect(association.macro).to eq :has_one
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
