require "rails_helper"

RSpec.describe "devise/sessions#new", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com") }
  
  before do
    sign_in(user)
  end

    # it "正常なレスポンスを返すこと" do
    #   get new_user_session_path
    #   expect(response).to be_successful
    #   expect(response.status).to eq 200
    # end
  describe "GET #show" do
    context "本人の場合" do
      it "正常なレスポンスを返すこと" do
        get user_path(user)
        expect(response.status).to eq 200
      end
    end
    context "本人ではない場合" do
      it "リダイレクトされること" do
        get user_path(other_user)
        expect(response).to redirect_to root_path
      end
    end
  end

end

