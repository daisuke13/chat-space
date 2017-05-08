class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to :root, notice: "グループを作成しました"
    else
      flash.now[:alert] = "グループ名を入力してください"
    end
  end

  def edit
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
