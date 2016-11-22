class UsersController < ApplicationController
  before_action :set_user, only: [:show, :invite, :uninvite, :block, :unblock]

  def dashboard
    @messages = Message.created_by(for_dashboard_user_ids)
  end

  def show
    redirect_to root_path, alert: t('access_denied') if @user.blocked?(current_user)
    @messages = Message.created_by(@user.id)
  end

  def invite
    friendship = current_user.friendships.build(friend_id: @user.id)
    @info = t('already_invited') unless friendship.save
    redirect_back_or_default(@info)
  end

  def uninvite
    current_user.friends.destroy(@user)
    redirect_back_or_default
  end

  def block
    blockade = current_user.by_user_blockades.build(blocked_id: @user.id)
    @info = t('already_blocked') unless blockade.save
    redirect_back_or_default(@info)
  end

  def unblock
    current_user.blocked_users.destroy(@user)
    redirect_back_or_default
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def for_dashboard_user_ids
    current_user.not_blocked_friends.distinct.pluck(:id) << current_user.id
  end
end
