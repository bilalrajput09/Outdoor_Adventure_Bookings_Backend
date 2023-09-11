require 'swagger_helper'

describe 'Adventures API' do
  path '/api/v1/adventures/{id}' do
    delete 'Delete Adventure' do
      tags 'Adventures'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Adventure ID'

      response '200', 'Adventure deleted successfully' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        let(:id) { create(:adventure).id } # Adventure will be deleted from the database
        run_test!
      end

      response '404', 'Adventure not found' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:id) { 999 } # Use a non-existent ID to trigger a 404 error
        run_test!
      end
    end
  end
end
