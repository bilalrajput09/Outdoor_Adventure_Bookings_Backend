require 'swagger_helper'

describe 'Adventures API' do
  path '/api/v1/adventures' do
    post 'Create Adventure' do
      tags 'Adventures'
      consumes 'application/json'
      parameter name: :adventure_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: {type: :integer},
          name: {type: :string},
          picture: {type: :string},
          description: {type: :text}
        },
        required: %w[name]
      }

      response '201', 'Adventure created successfully' do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 adventures: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: {type: :integer},
                       user_id: {type: :integer},
                       name: {type: :string},
                       picture: {type: :string},
                       description: {type: :text},
                       created_at: { type: :datetime },
                       updated_at: { type: :datetime }
                     },

                     required: %w[id name]
                   }
                 }
               },

               required: %w[message adventures]

        let(:user_id) { 2 }
        run_test!
      end

      response '204', 'Adventure creation error.' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        let(:user_id) { 2 }
        run_test!
      end
    end
  end
end
