class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(
      message: data['message'],
      user_id: current_user.id,
      room_id: data['room_id']
    )
  end
end
