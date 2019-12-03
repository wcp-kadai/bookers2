class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "room_channel_#{chat_message.room_id}", message: render_message(chat_message)
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: "rooms/chat_message", locals: { chat_message: message })
    end

end
