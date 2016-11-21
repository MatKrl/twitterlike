class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def dashboard
    @messages = [
      OpenStruct.new(content: 'Post numer jeden jakis tam 111'),
      OpenStruct.new(content: 'Post numer jeden jakis tam 222'),
      OpenStruct.new(content: 'Post numer jeden jakis tam 333'),
      OpenStruct.new(content: 'Post numer jeden jakis tam 444')
    ]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :username, :first_name, :last_name)
  end
end
