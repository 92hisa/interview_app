class PostsController < ApplicationController
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

  private
  def post_params
    params.require(:post).permit(:title, :email, :fee, :due_date, :experience, :detail).merge(user_id: current_user.id)
  end
end
