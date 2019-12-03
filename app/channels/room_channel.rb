class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ChatMessage.create!(from_id: data["from_id"], to_id: data["to_id"], room_id: data["room_id"], content: data["content"])
  end

end
