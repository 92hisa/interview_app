class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_post_user, only: [:edit, :update, :destroy]

  def new
  @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿が保存されました"
      redirect_to root_path
    else
      redirect_to new_post_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
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

  private

  def post_params
    params.require(:post).permit(:title, :email, :price, :experience, :detail).merge(user_id: current_user.id)
  end

  def correct_post_user
    post = Post.find_by(id: params[:id])
    if post.user.id != current_user.id
       redirect_to root_path
    end
  end
end
