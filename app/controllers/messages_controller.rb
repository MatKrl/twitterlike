class MessagesController < ApplicationController
  def create
    message = current_user.messages.build(message_params)
    @info = t('messages.create.failed') unless message.save
    redirect_back_or_default(@info)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
