require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:user3) { create(:user3) }
  let(:message1) { create(:message, user: user1) }
  let(:message2) { create(:message, user: user2) }
  let(:message3) { create(:message, user: user3) }

  before { sign_in(user1) }

  context 'When user have no friends and blockades' do
    describe 'and invite user' do
      before { get :invite, params: { user_id: user2.id } }
      it 'creates friendship' do
        expect(user1.reload.friend_with?(user2)).to be_truthy
      end
    end

    describe 'and block user' do
      before { get :block, params: { user_id: user3.id } }
      it 'creates blockade' do
        expect(user1.reload.blocked?(user3)).to be_truthy
      end
    end
  end

  context 'When user have friends and blockades' do
    before do
      message1
      message2
      user1.friends << user2
      user1.blocked_users << user3
    end

    describe 'GET dashboard' do
      before { get :dashboard }

      it 'assigns @messages' do
        expect(assigns(:messages).to_a).to eq([message1, message2])
      end

      it 'renders the dashboard template' do
        expect(response).to render_template('dashboard')
      end
    end

    describe 'GET show' do
      before { get :show, params: { id: user2.id } }
      it 'assigns @messages' do
        expect(assigns(:messages).to_a).to eq([message2])
      end
    end

    context '# validation against duplication' do
      describe '# invite user second time' do
        before { get :invite, params: { user_id: user2.id } }
        it '# shows error info' do
          expect(assigns(:info)).to be_kind_of(String)
        end
      end

      describe '# block user second time' do
        before { get :block, params: { user_id: user3.id } }
        it '# shows error info' do
          expect(assigns(:info)).to be_kind_of(String)
        end
      end
    end

    context '# removing relations' do
      describe '# uninvite user' do
        before { get :uninvite, params: { user_id: user2.id } }
        it '# removes friendship' do
          expect(user1.friend_with?(user2)).to be_falsey
        end
      end

      describe '# unblock user' do
        before { get :unblock, params: { user_id: user3.id } }
        it '# removes blockade' do
          expect(user1.blocked?(user3)).to be_falsey
        end
      end
    end
  end
end
