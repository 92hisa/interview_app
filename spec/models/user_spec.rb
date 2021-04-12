require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }

  describe "バリデーションテスト" do
    context "登録ができる場合" do
      it "正しい情報を入力すれば登録できること" do
        expect(user).to be_valid
      end

      it "画像がなくても登録できること" do
        user.profile_image = nil
        expect(user).to be_valid
      end

      it "紹介文がなくても登録できること" do
        user.about_me = nil
        expect(user).to be_valid
      end
    end

    context "登録ができない場合" do
      it "名前がなければ登録ができない" do
        user.name = nil
        user.valid?
        expect(user.errors.full_messages).to include("名前を入力してください")
      end

      it "メールアドレスがなければ登録ができない" do
        user.email = nil
        user.valid?
        expect(user.errors.full_messages).to include("Eメールを入力してください")
      end

      it "パスワードがなければ登録できない" do
        user.password = nil
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "メールアドレスに@がなければ登録ができない" do
        user.email = "sample"
        user.valid?
        expect(user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it "メールアドレスがすでに存在する場合は登録ができない" do
        user_second = FactoryBot.create(:user)
        user.email = user_second.email
        user.valid?
        expect(user.errors.full_messages).to include("Eメールはすでに存在します")
      end

      it "パスワードが6文字未満の場合は登録ができない" do
        user = build(:user, password: "a" * 5)
        user.valid?
        expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
    end

    describe "関連付けテスト" do
      let(:association) do
        described_class.reflect_on_association(target)
      end

      context "postとの関連" do
        let(:target) { :posts }

        it "postとの関連はhas_manyであること" do
          expect(association.macro).to eq :has_many
        end
      end

      context "purchaseとの関連" do
        let(:target) { :purchases }

        it "purchaseとの関連はhas_manyであること" do
          expect(association.macro).to eq :has_many
        end
      end

      context "messageとの関連" do
        let(:target) { :messages }

        it "messageとの関連はhas_manyであること" do
          expect(association.macro).to eq :has_many
        end
      end
    end
  end
end
