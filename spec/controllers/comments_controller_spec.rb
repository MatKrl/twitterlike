require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user1) }
  let(:message) { create(:user1_message, user: user) }

  context 'For logged in user' do
    before { sign_in(user) }

    describe 'POST create with correct params' do
      it 'create new comment' do
        post :create, params: { comment: { message_id: message.id, content: 'New comment to message!' } }
        expect(Comment.count).to eq(1)
      end
    end

    describe 'POST create with invalid params' do
      it 'shows error info' do
        post :create, params: { comment: { message_id: message.id, content: '' } }
        expect(assigns(:info)).to be_kind_of(String)
        expect(Comment.count).to eq(0)
      end
    end
  end
end
