require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  context 'For logged in user' do
    before(:each) do
      @user1 = create(:user1)
    end

    describe 'POST create with correct params' do
      it 'create new message' do
        sign_in(@user1)
        post :create, params: { message: { content: 'New amazing message!' } }
        expect(Message.count).to eq(1)
      end
    end

    describe 'POST create with invalid params' do
      it 'shows error info' do
        sign_in(@user1)
        post :create, params: { message: { content: '' } }
        expect(assigns(:info)).to be_kind_of(String)
        expect(Message.count).to eq(0)
      end
    end
  end
end
