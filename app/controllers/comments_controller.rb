class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = "コメントしました"
      redirect_to post_path(id: @post.id)
    else
      flash[:alert] = "コメントできませんでした"
      redirect_to post_path(id: @post.id)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_to post_path(id: @post.id)
    else
      flash[:alert] = "コメントを削除できませんした"
      redirect_to post_path(id: @post.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment).merge(user_id: current_user.id)
  end

  def correct_user
    comment = Comment.find(params[:id])
    if comment.user_id != current_user.id
      redirect_to root_path
    end
  end
end
