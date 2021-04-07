require "rails_helper"

RSpec.describe "Post content update", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }
  let!(:first_post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }

  describe "投稿内容の変更（#edit）" do
    context "ログインしてる場合" do
      before do
        sign_in(user)
        get edit_post_path(first_post.id)
      end

      it "正常なレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end

    context "ログインしてない場合" do
      before do
        get edit_post_path(first_post.id)
      end

      it "ログインページへリダイレクトすること" do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "投稿内容の変更（#update）" do
    let!(:params) { { post: { title: "sample_2" } } }

    context "ログインしてる場合" do
      before do
        sign_in(user)
        put post_path(first_post.id), params: params
      end

      it "正常なレスポンスを返すこと" do
        expect(response.status).to eq 302
      end

      it "編集した内容に更新されていること" do
        expect(first_post.reload.title).to eq "sample_2"
      end

      it "編集完了後、掲載案件一覧へリダイレクトすること" do
        expect(response).to redirect_to post_list_user_path(user)
      end
    end

    context "ログインしてない場合" do
      it "トップページへリダイレクトすること" do
        put post_path(first_post.id), params: params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "他アカウントのユーザーの場合" do
      it "トップページへリダイレクトすること" do
        sign_in(other_user)
        put post_path(first_post.id), params: params
        expect(response).to redirect_to root_path
      end
    end
  end
end
