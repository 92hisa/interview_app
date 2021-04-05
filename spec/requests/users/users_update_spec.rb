require "rails_helper"

RSpec.describe "User infomation update", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }

  describe "登録情報変更（#edit）" do
    context "ログイン状態の場合" do
      before do
        sign_in(user)
        get edit_user_registration_path
      end

      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end

    context "ログイン状態でない場合" do
      before do
        get edit_user_registration_path
      end

      it "ログインページへリダイレクトすること" do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "登録情報変更（#update）" do
  let!(:params) { { user: { name: "user_2" } } }

    context "ログインしている場合" do
      before do
        sign_in(user)
        put user_registration_path, params: params
      end

      it "正常なレスポンスを返すこと" do
        expect(response.status).to eq 302
      end
      it "ユーザー名が更新されること" do
        expect(user.reload.name).to eq "user_2"
      end
      it "マイページにリダイレクトすること" do
        expect(response).to redirect_to user_path(user)
      end
    end

    context "ログインしてない場合" do
      it "トップページへリダイレクトすること" do
        put user_path(user.id), params: params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "他アカウントのユーザーの場合" do
      it "トップページへリダイレクトすること" do
        sign_in(other_user)
        put user_path(user.id), params: params
        expect(response).to redirect_to root_path
      end
    end
  end
end
