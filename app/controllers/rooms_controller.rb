class RoomsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @room_id = get_room_id
    @chat_messages = ChatMessage.where(room_id: @room_id)
  end

  private
    def get_room_id
      id1 = current_user.id
      id2 = params[:user_id].to_i
      if id1 < id2
        "#{id1}-#{id2}"
      else
        "#{id2}-#{id1}"
      end
    end
end
