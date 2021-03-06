class DmRoomsController < ApplicationController
  def create
    @dm_room = DmRoom.create(params.require(:dm_room).permit(:user_id))
    @entry1 = Entry.create(dm_room_id: @dm_room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :dm_room_id).merge(dm_room_id: @dm_room.id))
    redirect_to dm_room_path(@dm_room.id)
  end

  def show
    @dm_room = DmRoom.find(params[:id])
    if Entry.where(user_id: current_user.id, dm_room_id: @dm_room.id).present?
      @dms = @dm_room.dms.order(created_at: 'desc')
      @dm = Dm.new
      @entries = @dm_room.entries.where.not(user_id: current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
