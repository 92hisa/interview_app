class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to room_path(id: @room.id)
    else
      flash.now[:alert] = 'メッセージが送信できませんでした'
      redirect_to room_path(id: @room.id)
    end
  end

  private

  def message_params
    params.permit(:message, :room_id).merge(user_id: current_user.id)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
