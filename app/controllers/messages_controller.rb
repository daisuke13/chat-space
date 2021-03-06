class MessagesController < ApplicationController

  before_action :set_group, only: [:index, :create]
  before_action :set_messages, only: [:index, :create]

  def index
    @message = Message.new
    respond_to do |format|
      format.html
      format.json {
        @messages = Message.where("id > ?", params[:id])
      }
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      flash.now[:alert] = "エラーが発生しました"
      render :index
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_messages
    @messages = @group.messages.includes(:user)
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
