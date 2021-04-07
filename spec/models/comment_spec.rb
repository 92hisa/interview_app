require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }
  let!(:comments) { create(:comment, user: user, post: post, comment: "hello world") }

  describe "バリデーションテスト" do
    context "コメントが成功する場合" do
      it "有効な情報であればコメントできること" do
        expect(comments).to be_valid
      end
    end

    context "コメントが失敗する場合" do
      it "user_idがなければコメントできないこと" do
        comments.user_id = nil
        comments.valid?
        expect(comments).to be_invalid
      end
    end

    it "post_idがなければコメントできないこと" do
      comments.post_id = nil
      comments.valid?
      expect(comments).to be_invalid
    end

    it "commentがなければコメントできないこと" do
      comments.comment = nil
      comments.valid?
      expect(comments).to be_invalid
    end

    it "commentが101文字以上の場合コメントできないこと" do
      comments = build(:comment, comment: "a" * 101)
      comments.valid?
      expect(comments).to be_invalid
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
