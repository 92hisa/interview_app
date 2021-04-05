class PostsController < ApplicationController
  def index
    @post = Post.all
  end

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
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.create(post_params)
    if @post.save
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
    params.require(:post).permit(:title, :email, :fee, :due_date, :experience, :detail).merge(user_id: current_user.id)
  end
end
