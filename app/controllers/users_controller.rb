class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :invite, :uninvite, :block, :unblock]

  def dashboard
    @messages = Message.includes(:user).where(messages: { user_id: current_user.for_dashboard_user_ids })
  end

  def show
    redirect_to root_path, alert: t('access_denied') if @user.blocked_users.include?(current_user)
    @messages = Message.includes(:user).where(user_id: @user.id)
  end

  def invite
    begin
      current_user.friends << @user
    rescue ActiveRecord::RecordInvalid
      message = t('already_invited')
    end
    # debugger
    redirect_back_or_default(message)
  end

  def uninvite
    current_user.friends.destroy(@user)
    redirect_back_or_default
  end

  def block
    begin
      current_user.blocked_users << @user
    rescue ActiveRecord::RecordInvalid
      message = t('already_blocked')
    end
    redirect_back_or_default(message)
  end

  def unblock
    current_user.blocked_users.destroy(@user)
    redirect_back_or_default
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def redirect_back_or_default(message = '')
    redirect_back(fallback_location: root_path, alert: message)
  end
end
