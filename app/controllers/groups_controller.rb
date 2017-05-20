class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    binding.pry
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: "グループを作成しました"
    else
      flash.now[:alert] = "グループ名を入力してください"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: '編集されました'
    else
      flash.now[:alert] = "エラーが発生しました"
      render :edit
    end
  end

  def index
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end

