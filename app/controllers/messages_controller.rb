class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    # @roomにここでidを渡すことでform_withで役立つ
    @messages = @room.messages.includes(:user)
    # ルームに紐付いている全メッセージ（@room.messages）を@messagesと定義
  end

  def create
    @room = Room.find(params[:room_id])
    # 先に親であるroomのidを取得
    @message = @room.messages.new(message_params)
    # メッセージを作る時に@roomで　どのルームかを明記
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      # 投稿に失敗したとき@messageの情報を保持させる
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
    # merge(user_id: current_user.id)でコメントした本人を限定する
  end

end
