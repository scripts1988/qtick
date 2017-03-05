class UsersController < ApplicationController
  def new
    @user = User.new(email: params[:email])
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome to qTick, " + @user.name
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
