class RoomsController < ApplicationController
  before_action :set_room, only: :show

  def show
      @purchase = @room.purchase
      @post = Post.find_by(id: @purchase.post_id)
      @saler = User.find_by(id: @purchase.saler_id)
      @buyer = User.find_by(id: @purchase.buyer_id)
  end

  private
  def set_room
    @room = Room.find_by(purchase_id: params[:id])
    if @room.nil?
      @room = Room.new(id: params[:id], purchase_id: params[:id])
      @room.save
    end
  end
end

  # def private
  #   def set_room
  #     @room = Room.find_by(purchase_id: params[:id]
      
  #     if @room.nil?
  #       @room = Room.new(purchase_id: params[:id]
  #       @room.save
  #     end
  #   end
  # end
  # def new
  #   if user_signed_in?
  #     @room = Room.new
  #     @rooms = current_user.rooms
  #     @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
  #   end
  # end

  # def create
  #   @room = Room.new(room_params)
  #   @room.save
  #   current_user.user_rooms.create(room_id: @room.id)
  #   redirect_to action: :show, id: @room.id
  # end

  # def show
  #   @room = Room.find(params[:id])
  #   @chats = @room.chats
  # end

  # private
  # def room_params
  #   params.require(:room).permit(:name)
  # end
