class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    @info = t('comments.create.failed') unless comment.save
    redirect_back_or_default(@info)
  end

  private

  def comment_params
    params.require(:comment).permit(:message_id, :content)
  end
end
