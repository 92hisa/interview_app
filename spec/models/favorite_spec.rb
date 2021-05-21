require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 500, experience: "rails") }
  let!(:favorite) { create(:favorite, user_id: user.id, post_id: new_post.id) }

  describe "バリデーションテスト" do
    context "お気に入りが保存できる場合" do
      it "有効な情報であればお気に入りできること" do
        expect(favorite).to be_valid
      end
    end

    context "お気に入りが保存できない場合" do
      it "user_idがなければお気に入りできないこと" do
        favorite.user_id = nil
        favorite.valid?
        expect(favorite).to be_invalid
      end
    end

    it "post_idがなければお気に入りできないこと" do
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
