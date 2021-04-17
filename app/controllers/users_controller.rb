class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, except: [:show]

  def show
    @user = User.find(params[:id])
    @post_favorite = Post.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @favorite_count = @post_favorite.select{ |post| post.user_id == current_user.id }.count
    @user_posts = @user.posts.order(id: "desc")
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "ユーザー情報が更新されました"
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "ユーザー情報が更新できませんでした"
      redirect_to user_path(current_user.id)
    end
  end

  def post_list
    @post_list = current_user.posts
  end

  # （購入向け）購入履歴
  def purchase_logs
    @purchase_logs = Purchase.where(user_id: current_user.id).includes(post: :user)
  end

  def favorite_list
    @favorite_posts = current_user.favorites.includes(:post)
  end


  private

  def user_params
    params.require(:user).permit(:gender, :about_me)
  end

  def correct_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to root_path
    end
  end
end
