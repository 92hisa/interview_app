require "rails_helper"

RSpec.describe "comments#create", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 500, experience: "rails") }
  let!(:comment) { create(:comment, user_id: user.id, post_id: new_post.id, comment: "hello world") }

  describe "ログインしている場合" do
    before do
      sign_in(user)
      get post_path(new_post)
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it "有効なparamsを渡した場合、登録できること" do
      expect {
        post post_comments_path(new_post.id), params: { comment: { user_id: user.id, post_id: new_post.id, comment: "hello world" } }
      }.to change(Comment, :count).by(1)
    end

    it "無効なparamsを渡した場合、登録できないこと" do
      expect {
        post post_comments_path(new_post.id), params: { comment: { user_id: user.id, post_id: new_post.id, comment: "" } }
      }.not_to change(Comment, :count)
    end
  end

  describe "ログインしていない場合" do
    before do
      get post_path(new_post.id)
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it "「送信する」を押すとトップページへリダイレクトすこと" do
      post post_comments_path(new_post.id)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
