class ChatMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # ブロードキャスト処理
    ActionCable.server.broadcast "room_channel_#{chat_message.room_id}", message: render_message(chat_message) # ここで下のメソッドを呼び出し
  end

  private
    def render_message(message) # 引数のchat_messageオブジェクトを元にテンプレートを生成するメソッド
      # コントローラーファイルとスコープが異なるのでrenderメソッドは以下のように呼び出す必要がある
      ApplicationController.renderer.render(partial: "rooms/chat_message", locals: { chat_message: message })
    end

end
