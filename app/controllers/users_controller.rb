class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def post_list
    @post_list = current_user.posts
  end

  #（購入向け）購入履歴
  def purchase_logs
    @purchase_logs = Purchase.where(user_id: current_user.id).includes(post: :user)
  end
end
