require "rails_helper"

RSpec.describe "New user registration", type: :request do
  before do
    get new_user_registration_path
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_successful
    expect(response.status).to eq 200
  end

  describe "新規ユーザー登録を行う場合" do
    context "有効なユーザー情報である場合" do
      it "正常にユーザー登録されること" do
        expect {
          post user_registration_path, params: { user: { name: "user", email: "user@example.com", password: "password", gender: "man" } }
        }.to change(User, :count).by(1)
      end
    end

    context "nameがnillである場合" do
      it "ユーザー登録されないこと" do
        expect {
          post user_registration_path, params: { user: { name: "", email: "user@example.com", password: "password", gender: "man" } }
        }.not_to change(User, :count)
      end
    end

    context "passwordが6文字以下である場合" do
      it "ユーザー登録されないこと" do
        expect {
          post user_registration_path, params: { user: { name: "user", email: "user@example.com", password: "abc", gender: "man" } }
        }.not_to change(User, :count)
      end
    end

    context "ユーザー情報が重複している場合" do
      let(:user) { create(:user, name: "user", email: "user@example.com", password: "password", gender: "man") }

      it "ユーザー登録されないこと" do
        expect { post user_registration_path, params: @user }.not_to change(User, :count)
      end
    end
  end
end
