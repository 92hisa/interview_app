require "rails_helper"

RSpec.describe "User login", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }

  describe "マイページ(#show)を表示する場合" do
    context "ログインしている場合" do
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
    end

    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
