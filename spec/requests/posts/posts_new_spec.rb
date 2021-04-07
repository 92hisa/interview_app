require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }

  describe "ログインしている場合" do
    before do
      sign_in(user)
      get new_post_path
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it "有効なデータで登録できること" do
      expect {
        post posts_path, params: { post: { title: "sample", price: 100, experience: "rails" } }
      }.to change(Post, :count).by(1)
    end

    it "無効なデータでは登録できないこと" do
      expect {
        post posts_path, params: { post: { title: "", price: 100, experience: "rails" } }
      }.not_to change(Post, :count)
    end
  end

  describe "ログインしていない場合" do
    before do
      get new_post_path
    end

    context "投稿画面へアクセスしたとき" do
      it "トップページへリダイレクトすること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
