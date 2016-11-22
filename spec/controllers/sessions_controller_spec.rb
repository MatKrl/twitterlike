require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  context "For not logged in user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user1 = create(:user1)
    end

    describe "POST create" do
      it "create new message" do
        post :create, params: { user: { email: @user1.email, password: @user1.password, remember_me: '0' } }
        expect(subject.current_user).not_to be_nil
        expect(subject.current_user).to eq(@user1)
      end
    end
  end
end
