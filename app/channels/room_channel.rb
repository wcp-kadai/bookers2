class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}" # ストリームするチャンネルを指定
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data) # フロント側のperformメソッドにより呼び出された時に実行
    # ChatMessageモデルの作成
    # 作成後(commit transaction後)に登録したjob(ブロードキャスト処理)が呼び出される
    ChatMessage.create!(from_id: data["from_id"], to_id: data["to_id"], room_id: data["room_id"], content: data["content"])
  end

end
