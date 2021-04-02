class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def post_list
    @post_list = current_user.posts
  end
end
