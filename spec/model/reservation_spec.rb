require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validation' do
    let(:user) { User.new(username: "Bilal")}
    let(:adventure) { Adventure.new(name: "Cycling", picture: "cycling.png", description: "I am doing cycling")}

    before do
        user.save
        adventure.save
    end
    it "validates the reservation association" do
        reservation = Reservation.new(user_id: user.id)
        reservation.save
        expect(reservation).to_not be_valid
        reservation = Reservation.new(user_id: user.id, adventure_id: adventure.id)
        reservation.save 
        expect(reservation).to be_valid
    end
    
  end
end