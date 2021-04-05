require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }

  describe "マイページ（#show）" do
    context "ログイン状態の場合" do
        before do
          sign_in(user)
        end

        context "本人の場合" do
          it "正常なレスポンスを返すこと" do
            get user_path(user)
            expect(response).to be_successful
            expect(response.status).to eq 200
          end
        end

        context "本人ではない場合" do
          it "トップページへリダイレクトすること" do
            get user_path(other_user)
            expect(response).to redirect_to root_path
          end
        end
    end

    context "ログイン状態でない場合" do
      it "ログインページへリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to user_session_path
      end
    end
  end

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
end
