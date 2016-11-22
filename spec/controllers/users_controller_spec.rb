require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "For user with friend and blockade" do
    before(:each) do
      @user1 = create(:user1)
      @user2 = create(:user2)
      @user3 = create(:user3)
      @user1.friends << @user2
      @user1.blocked_users << @user3
      @message1 = create(:message, user: @user1)
      @message2 = create(:message, user: @user2)
      @message3 = create(:message, user: @user3)
    end

    describe "GET dashboard" do
      it "assigns @messages" do
        sign_in(@user1)
        get :dashboard
        expect(assigns(:messages).to_a).to eq([@message1, @message2])
      end

      it "renders the dashboard template" do
        sign_in(@user1)
        get :dashboard
        expect(response).to render_template("dashboard")
      end
    end

    describe "GET show" do
      it "assigns @messages" do
        sign_in(@user1)
        get :show, params: { id: @user2.id }
        expect(assigns(:messages).to_a).to eq([@message2])
      end
    end

    describe "invite user second time" do
      it "shows error info" do
        sign_in(@user1)
        get :invite, params: { user_id: @user2.id }
        expect(assigns(:info)).to be_kind_of(String)
      end
    end

    describe "block user second time" do
      it "shows error info" do
        sign_in(@user1)
        get :block, params: { user_id: @user3.id }
        expect(assigns(:info)).to be_kind_of(String)
      end
    end

    describe "uninvite user" do
      it "removes friendship" do
        sign_in(@user1)
        get :uninvite, params: { user_id: @user2.id }
        expect(@user1.reload.friend_with?(@user2)).to be false
      end
    end

    describe "unblock user" do
      it "removes blockade" do
        sign_in(@user1)
        get :unblock, params: { user_id: @user3.id }
        expect(@user1.reload.blocked?(@user3)).to be false
      end
    end
  end

  context "When user have no friends and blockades" do
    before(:each) do
      @user1 = create(:user1)
      @user2 = create(:user2)
      @user3 = create(:user3)
    end

    describe "and invite user" do
      it "creates friendship" do
        sign_in(@user1)
        get :invite, params: { user_id: @user2.id }
        expect(@user1.reload.friend_with?(@user2)).to be true
      end
    end

    describe "and block user" do
      it "creates blockade" do
        sign_in(@user1)
        get :block, params: { user_id: @user3.id }
        expect(@user1.reload.blocked?(@user3)).to be true
      end
    end
  end
end
