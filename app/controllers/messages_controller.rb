class MessagesController < ApplicationController
  def create
    message = Message.new(message_params.merge(user: current_user))
    @info = t('messages.create.failed') unless message.save
    redirect_back_or_default(@info)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
