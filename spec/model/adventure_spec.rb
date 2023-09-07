require 'rails_helper'

RSpec.describe Adventure, type: :model do
  describe 'validation' do
    let(:user) { User.new(username: 'Bilal') }
    let(:adventure) { Adventure.new(name: 'Cycling', picture: 'cycling.png', description: 'I am doing cycling') }

    before do
      user.save
      adventure.save
    end
    it 'validates the adventure association' do
      reservation = Reservation.new(user_id: user.id, adventure_id: adventure.id)
      reservation.save
      adventure.reservations << reservation
      expect(adventure.reservations.length).to eql(1)
    end
  end
end
