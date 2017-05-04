class UsersController < ApplicationController
  def edit
    binding.pry
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
  end

  private
  def user_params
    params.permit(:name)
  end
end
