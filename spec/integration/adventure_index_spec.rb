require 'swagger_helper'

describe 'Adventures index API' do
  path '/api/v1/adventures' do
    get 'Get index of adventures' do
      tags 'Adventures'
      produces 'application/json'

      response '200', 'List of adventures retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :text },
                   picture: { type: :string },
                   created_at: { type: :datetime },
                   updated_at: { type: :datetime }
                 },
                 required: %w[id name picture description]
               }

        let(:adventure) { Adventure.all }
        run_test!
      end
    end
  end
end
