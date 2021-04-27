class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, except: [:show]

  def show
    @user = User.find(params[:id])
    @post_favorite = Post.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @favorite_count = @post_favorite.select { |post| post.user_id == current_user.id }.count
    @user_posts = @user.posts.order(id: "desc")
    @reviews = Review.includes(:user).where(saler_id: @user.id).order(id: "desc").all

    # dm
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |current_user_entry|
        @user_entry.each do |user_entry|
          if current_user_entry.dm_room_id == user_entry.dm_room_id
            @is_dm_room = true
            @dm_room_id = current_user_entry
          end
        end
      end
      unless @is_dm_room
        @dm_room = DmRoom.new
        @entry = Entry.new
      end
    end
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

  def follows
    follower = Relationship.where(follow_id: current_user.id).pluck(:follow_id)
    @followers = User.where(id: follower)

    follow = Relationship.where(user_id: current_user.id).pluck(:follow_id)
    @follows = User.where(id: follow)
  end

  def dm_list
    # @entries = Entry.where(user_id: current_user.id).pluck(:dm_room_id)
    # # @opened_dm_rooms = Entry.includes(:user).where(dm_room_id: @entries).select(:user_id).distinct.pluck(:user_id)
    # @opened_dm_rooms = Entry.group(:dm_room_id, :user_id).where(dm_room_id: @entries)
    # @opended_dm_rooms = Entry.find(Dm.group(:dm_room_id).order('count(dm_room_id) desc').all.pluck(:dm_room_id))
    @current_entries = current_user.entries
    my_dm_room_ids = []
    @current_entries.each do |entry|
      my_dm_room_ids << entry.dm_room_id
    end
    @another_entries = Entry.where(dm_room_id: myDmRoomIds).where('user_id != ?', current_user.id).order(created_at: 'desc')
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
