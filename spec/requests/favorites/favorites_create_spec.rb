require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:new_post) { create(:post, user: user, title: "sample", price: 100, experience: "rails") }
  let!(:favorite) { build(:favorite, user_id: user.id, post_id: new_post.id) }
  

  describe "ログインしている場合" do
    before do
      sign_in(user)
      get post_path(new_post.id)
    end

    it "有効なparamsを渡した場合、登録できること" do
      expect { post post_favorites_path(new_post.id), params: { favorite: { user_id: user.id, post_id: new_post.id } }
      }.to change(Favorite, :count).by(1)
    end
  end

  describe "ログインしていない場合" do
    before do
      get post_path(new_post.id)
    end

    it "「お気に入り」を押すとトップページへリダイレクトすこと" do
      post post_favorites_path(new_post.id)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
