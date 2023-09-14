require 'swagger_helper'

describe 'Rservations API' do
  path '/api/v1/fetch_reservations' do
    post 'Fetch Reservations' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :currentUserID, in: :body, schema: {
        type: :object,
        properties: {
          currentUserID: { type: :integer }
        },
        required: ['currentUserID']
      }

      response '200', 'Reservations fetched successfully' do
        schema type: :array,
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
        run_test!
      end

      response '204', 'No reservation found' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        let(:currentUserID) { 20 }
        run_test!
      end
    end
  end
end
