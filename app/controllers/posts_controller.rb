class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_post_user, only: [:edit, :update, :destroy]

  def new
  @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save!
      flash[:notice] = "投稿が保存されました"
      redirect_to root_path
    else
      render 'new'
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(id: "desc")
    @post_favorite = @post.favorites.where(user_id: current_user)
    @favorite_count = @post.favorites.count
    @user = @post.user
    @user_posts = @user.posts.order(id: "desc")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集が完了しました"
      redirect_to post_list_user_path(id: current_user.id)
    else
      flash[:alert] = "編集できませんでした"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.delete
      flash[:notice] = "削除が完了しました"
      redirect_to post_list_user_path(id: current_user.id)
    else
      flash[:alert] = "削除ができませんでした"
      redirect_to new_post_path
    end
  end

  def index
    @post = Post.all.order(created_at: 'desc')
    @categories = Category.all
    @search_word = Post.ransack(params[:q])
  end

  def search
    @search_word = Post.ransack(params[:q])
    @search = @search_word.result(distinct: true)
    @categories = Category.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :subtitle, :plan_image, :way, :price, :experience, :detail, category_ids: []).
      merge(user_id: current_user.id)
  end

  def correct_post_user
    post = Post.find_by(id: params[:id])
    if post.user.id != current_user.id
       redirect_to root_path
    end
  end
end
