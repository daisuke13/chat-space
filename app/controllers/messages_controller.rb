class MessagesController < ApplicationController

  before_action :set_group, only: [:index, :create]
  before_action :set_messages, only: [:index, :create]

  def index
    # binding.pry
    @message = Message.new
    # binding.pry
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path
    else
      flash.now[:alert] = "エラーが発生しました"
      render :index
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_messages
    # binding.pry
    @messages = @group.messages.includes(:user)
    # binding.pry
  end

  private
  def message_params
    params.require(:message).permit(:body).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
