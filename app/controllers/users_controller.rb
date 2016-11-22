class UsersController < ApplicationController
  before_action :set_user, only: [:show, :invite, :uninvite, :block, :unblock]

  def dashboard
    @messages = find_messages(current_user.for_dashboard_user_ids)
  end

  def show
    redirect_to root_path, alert: t('access_denied') if @user.blocked_users.include?(current_user)
    @messages = find_messages(@user.id)
  end

  def invite
    begin
      current_user.friends << @user
    rescue ActiveRecord::RecordInvalid
      info = t('already_invited')
    end
    redirect_back_or_default(info)
  end

  def uninvite
    current_user.friends.destroy(@user)
    redirect_back_or_default
  end

  def block
    begin
      current_user.blocked_users << @user
    rescue ActiveRecord::RecordInvalid
      info = t('already_blocked')
    end
    redirect_back_or_default(info)
  end

  def unblock
    current_user.blocked_users.destroy(@user)
    redirect_back_or_default
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def find_messages(user_ids)
    Message.includes(:user, comments: :user)
           .where(messages: { user_id: user_ids })
           .order('messages.created_at DESC')
  end
end
