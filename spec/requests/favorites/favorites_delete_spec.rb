require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 500, experience: "rails") }
  let!(:favorite) { create(:favorite, user_id: user.id, post_id: new_post.id) }

  describe "ログインしている場合" do
    context "コメントした本人の場合" do
      before do
        sign_in(user)
        get post_path(new_post.id)
      end

      it "お気に入りの削除ができること" do
        expect { delete post_favorite_path(new_post.id, favorite.id) }.to change(Favorite, :count).by(-1)
      end
    end
  end

  describe "ログインしていない場合" do
    before do
      get post_path(new_post.id)
    end

    it "お気に入りの削除はできずログインへリダイレクトされること" do
      delete post_favorite_path(new_post.id, favorite.id)
      expect(response).to redirect_to root_path
    end
  end
end
