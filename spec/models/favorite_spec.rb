require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }
  let!(:favorite) { create(:favorite, user_id: user.id, post_id: new_post.id) }

  describe "バリデーションテスト" do
    context "コメントが成功する場合" do
      it "有効な情報であればコメントできること" do
        expect(favorite).to be_valid
      end
    end

    context "コメントが失敗する場合" do
      it "user_idがなければコメントできないこと" do
        favorite.user_id = nil
        favorite.valid?
        expect(favorite).to be_invalid
      end
    end

    it "post_idがなければコメントできないこと" do
      favorite.post_id = nil
      favorite.valid?
      expect(favorite).to be_invalid
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

    context "postとの関連" do
      let(:target) { :post }

      it "postとの関連はbelongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
