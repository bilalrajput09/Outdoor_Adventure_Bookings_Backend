require 'swagger_helper'

describe 'Rservations API' do
  path '/api/v1/reservations' do
    post 'Reservations' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :reservation_params, in: :body, schema: {
        type: :object,
        properties: {
          currentUserID: { type: :integer },
          adventureID: { type: :integer }
        },
        required: %w[currentUserID adventureID]
      }

      response '201', 'Reservation created successfully' do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 reservations: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       user_ud: { type: :integer },
                       reservation_id: { type: :integer },
                       created_at: { type: :datetime },
                       updated_at: { type: :datetime }
                     },

                     required: %w[id user_id reservation_id]
                   }
                 }
               },

               required: %w[message reservations]

        let(:currentUserID) { 20 }
        let(:adventureID) { 5 }
        run_test!
      end

      response '204', 'No reservation found' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        let(:currentUserID) { 20 }
        let(:adventureID) { 5 }
        run_test!
      end
    end
  end
end
