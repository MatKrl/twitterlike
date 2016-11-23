require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:user3) { create(:user3) }

  describe "#full_name" do
    let(:user1) { User.new(first_name: "Andy", last_name: "Black") }

    it 'returns full name' do
      expect(user1.full_name).to eq('Andy Black')
    end
  end

  describe "#all_other_users" do
    it 'returns all other users' do
      expect(user1.all_other_users).to eq([user2, user3])
    end
  end

  describe ".callbacks" do
    describe "#create_connected_friendship" do
      before { user1.friends << user2 }

      it 'sets reversed friendship relation' do
        expect(user2.friends).to eq([user1])
      end
    end
  end

  describe "#friend_with?" do
    context "with friends" do
      before { user1.friends << user2 }

      it 'confirm friendship' do
        expect(user1.friend_with?(user2)).to be_truthy
      end
    end

    context "without friends" do
      it 'confirm no friendship' do
        expect(user1.friend_with?(user2)).to be_falsey
      end
    end
  end

  describe "#blocked?" do
    context "with blocked users" do
      before { user1.blocked_users << user3 }

      it 'confirm blockade' do
        expect(user1.blocked?(user3)).to be_truthy
      end
    end

    context "without blockade" do
      it 'confirm no blockade' do
        expect(user1.blocked?(user3)).to be_falsey
      end
    end
  end

  describe "#not_blocked_friends?" do
    before do 
      user1.friends << user2
      user1.friends << user3
    end
    context "with blockade created by current user" do
      before { user1.blocked_users << user2 }
      it 'returns not blocked friends' do
        expect(user1.not_blocked_friends).to eq([user3])
      end
    end

    context "with blockade created by other user" do
      before { user3.blocked_users << user1 }
      it 'returns friends who not blocked user' do
        expect(user1.not_blocked_friends).to eq([user2])
      end
    end
  end
end
