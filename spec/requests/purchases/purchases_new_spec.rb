require "rails_helper"

RSpec.describe "Purchases", type: :request do
  let!(:saler) { create(:user, name: "user", email: "user@example.com", gender: "man") }
  let!(:buyer) { create(:user, name: "other_user", email: "other_user@example.com", gender: "woman") }
  let!(:first_post) { create(:post, user: saler) }
  let!(:purchase) { create(:purchase, user_id: buyer.id, post_id: first_post.id, saler_id: saler.id, buyer_id: buyer.id) }

  describe "ログインしている場合" do
    before do
      sign_in(buyer)
      get new_post_purchase_path(first_post.id)
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it "購入処理が行われること" do
      expect {
        post post_purchases_path(first_post.id),
             params: { purchase: { user_id: buyer.id, post_id: first_post.id, saler_id: saler.id, buyer_id: buyer.id } }
      }.to change(Purchase, :count).by(1)
    end
  end

  describe "ログインしてない場合" do
    before do
      get new_post_purchase_path(first_post.id)
    end

    context "購入ページへアクセスしたとき" do
      it "トップページへリダイレクトすること" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    it "購入処理は行われないこと" do
      expect {
        post post_purchases_path(first_post.id),
             params: { purchase: { user_id: buyer.id, post_id: first_post.id, saler_id: saler.id, buyer_id: buyer.id } }
      }.not_to change(Purchase, :count)
    end
  end
end
