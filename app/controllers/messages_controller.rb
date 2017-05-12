class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = Message.all
  end

  def create
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path
    else
      flash.now[:alert] = "エラーが発生しました"
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
