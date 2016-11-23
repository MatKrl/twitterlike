require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user1) }

  context 'For logged in user' do    
    before { sign_in(user) }
  
    describe 'POST create with correct params' do
      it 'creates new message' do
        post :create, params: { message: { content: 'New amazing message!' } }
        expect(Message.count).to eq(1)
      end
    end

    describe 'POST create with invalid params' do
      it 'shows error info' do
        post :create, params: { message: { content: '' } }
        expect(assigns(:info)).to be_kind_of(String)
        expect(Message.count).to eq(0)
      end
    end
  end
end
