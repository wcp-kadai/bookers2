class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat_message = ChatMessage.create!(from_id: data["from_id"], to_id: data["to_id"], room_id: data["room_id"], content: data["content"])
    ActionCable.server.broadcast "room_channel_#{data["room_id"]}", message: render_message(chat_message)
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: "rooms/chat_message", locals: { chat_message: message })
    end
end
