class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params.merge(user: current_user))
    @info = t('comments.create.failed') unless comment.save
    redirect_back_or_default(@info)
  end

  private

  def comment_params
    params.require(:comment).permit(:message_id, :content)
  end
end
