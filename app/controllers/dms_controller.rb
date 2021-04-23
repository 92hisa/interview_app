class DmsController < ApplicationController
  def create
    @entry = Entry.where(user_id: current_user.id, dm_room_id: params[:dm][:dm_room_id])
    if @entry.present?
      @dm = Dm.create!(params.require(:dm).permit(:user_id, :text, :dm_room_id).merge(user_id: current_user.id))
      @dm.create_notification_dm!(current_user, @dm.id)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    redirect_to dm_room_path(@dm.dm_room_id)
  end
end
