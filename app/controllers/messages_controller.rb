class MessagesController < ApplicationController

  before_action :definition, only: [:index, :create]

  def index
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    @groups = current_user.groups
    @message = Message.new(message_params)
    @messages = @group.messages.includes(:user)
    if @message.save
      redirect_to group_messages_path
    else
      flash.now[:alert] = "エラーが発生しました"
      render :index
    end
  end

  def definition
    @group = Group.find(params[:group_id])
  end

  private
  def message_params
    params.require(:message).permit(:body).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
