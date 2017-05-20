class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_with_password(user_params)
      redirect_to root_path, notice: '編集されました'
    else
      redirect_to edit_user_path, alert: 'エラーが発生しました'
    end
  end

  def search
    @users = User.where('name like?', "%#{params[:keyword]}%")
    respond_to do |format|
      format.json
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :current_password)
  end
end
