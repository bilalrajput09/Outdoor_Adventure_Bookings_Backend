require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of username' do
      user = User.new(username: nil)
      user.save
      expect(user).to_not be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "validates uniqueness of username" do
        user1 = User.create(username: "Bilal")
        user2 = User.new(username: "Bilal")

        user2.save 
        expect(user2).to_not be_valid
    end
  end
end