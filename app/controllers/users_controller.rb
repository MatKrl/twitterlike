class UsersController < ApplicationController
  def dashboard
    @messages = Message.includes(:user).where(messages: { user_id: current_user.for_dashboard_user_ids })
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: t('access_denied') if @user.blocked_users.include?(current_user)
    @messages = Message.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :first_name, :last_name)
  end
end
