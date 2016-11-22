require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = create(:user1)
    @user2 = create(:user2)
    @user3 = create(:user3)
    @user1.friends << @user2
    @user1.blocked_users << @user3
  end

  context "with friend and blockade" do
    it "have reversed friendship relation" do
      expect(@user2.reload.friends).to eq([@user1])
    end

    it "have reversed blockade relation" do
      expect(@user3.reload.blocked_by_users).to eq([@user1])
    end

    it "return correct users for dashboard" do
      expect(@user1.reload.for_dashboard_user_ids).to eq([@user2.id, @user1.id])
    end

    it "removing connected friendship when unlike" do
      @user1.friends.destroy(@user2)
      expect(@user2.reload.friends).to eq([])
    end    
  end

  it "return full name" do
    expect(@user1.reload.full_name).to eq('Andy Black')
  end

  it "return other users" do
    expect(@user1.reload.all_other_users).to eq([@user2, @user3])
  end

  it "confirm friendship" do
    expect(@user1.reload.friend_with?(@user2)).to be true
  end

  it "confirm blockade" do
    expect(@user1.reload.blocked?(@user3)).to be true
  end
end
