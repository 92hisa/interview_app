require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:post) { create(:post, user: user, title: "sample", price: 500, experience: "rails") }
  let!(:favorite) { create(:favorite, user_id: user.id, post_id: post.id) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(post).to be_valid
      end

      it "画像がなくても登録できること" do
        post.plan_image = nil
        post.valid?
        expect(post).to be_valid
      end

      it "詳細がなくても登録できること" do
        post.detail = nil
        post.valid?
        expect(post).to be_valid
      end
    end

    context "登録できないとき" do
      it "user_idがなければ登録できないこと" do
        post.user_id = nil
        post.valid?
        expect(post).to be_invalid
      end

      it "タイトルがなければ登録できないこと" do
        post.title = nil
        post.valid?
        expect(post).to be_invalid
      end

      it "サブタイトルがなければ登録できないこと" do
        post.subtitle = nil
        post.valid?
        expect(post).to be_invalid
      end

      it "価格がなければ登録できないこと" do
        post.price = nil
        post.valid?
        expect(post).to be_invalid
      end

      it "経験がなければ登録できないこと" do
        post.experience = nil
        post.valid?
        expect(post).to be_invalid
      end

      it "タイトルが30文字以下でなければ登録できないこと" do
        post = build(:post, title: "a" * 31)
        post.valid?
        expect(post).to be_invalid
      end

      it "サブタイトルが50文字以下でなければ登録できないこと" do
        post = build(:post, subtitle: "a" * 51)
        post.valid?
        expect(post).to be_invalid
      end

      it "価格は500円以上でなければ登録できないこと" do
        post = build(:post, price: 499)
        post.valid?
        expect(post).to be_invalid
      end

      it "価格は1,000,000円以下でなければ登録できないこと" do
        post = build(:post, price: 1000001)
        post.valid?
        expect(post).to be_invalid
      end

      it "経験は20文字以下でなければ登録できないこと" do
        post = build(:post, experience: "a" * 21)
        post.valid?
        expect(post).to be_invalid
      end

      it "詳細は150文字以下でなければ登録できないこと" do
        post = build(:post, detail: "a" * 151)
        post.valid?
        expect(post).to be_invalid
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
      let(:target) { :purchases }

      it "purchaseとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "commentとの関連" do
      let(:target) { :comments }

      it "commentとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "favoriteとの関連" do
      let(:target) { :favorites }

      it "favoriteとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "post_category_relationとの関連" do
      let(:target) { :post_category_relations }

      it "post_category_relationとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "categoryとの関連" do
      let(:target) { :categories }

      it "categoryとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "notificationとの関連" do
      let(:target) { :notifications }

      it "notificationとの関連はhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end

  describe "インスタンスメソッドテスト" do
    context "taxメソッド" do
      it "消費税を含めた金額に変換すること" do
        expect(post.tax).to eq "550"
      end
    end

    context "same_favoriteメソッド" do
      it "user_idとpost_id に紐付いたお気に入りを取得できること" do
        expect(post.same_favorite(user)).to be_truthy
      end
    end

    context "favorite_countメソッド" do
      it "お気に入りの数をカウントできること" do
        expect(post.favorite_count).to eq 1
      end
    end
  end
end
