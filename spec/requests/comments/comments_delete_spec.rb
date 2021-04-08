require "rails_helper"

RSpec.describe "comments#destroy", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:other_user) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }
  let!(:comment) { create(:comment, user_id: user.id, post_id: new_post.id, comment: "hello world") }

    describe "ログインしている場合" do
      context "コメントした本人の場合" do
        before do
          sign_in(user)
          get post_path(new_post.id)
        end

        it "コメントの削除ができること" do
          expect { delete post_comment_path(new_post.id, comment.id) }.to change(Comment, :count).by(-1)
        end
      end

      context "コメントした本人ではない場合" do
        before do
          sign_in(other_user)
          get post_path(new_post.id)
        end

        it "コメントの削除ができないこと" do
          expect { delete post_comment_path(new_post.id, comment.id) }.not_to change(Comment, :count)
        end
      end

    describe "ログインしていない場合" do
      before do
        get post_path(new_post.id)
      end

      it "コメントの削除はできずログインページへリダイレクトされること" do
        delete post_comment_path(new_post.id, comment.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
    end
end
