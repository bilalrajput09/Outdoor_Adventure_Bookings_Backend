require 'swagger_helper'

describe 'Adventures API' do
  path '/api/v1/adventures' do
    post 'Create Adventure' do
      tags 'Adventures'
      consumes 'application/json'
      parameter name: :adventure_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          name: { type: :string },
          picture: { type: :string },
          description: { type: :text }
        },
        required: %w[name]
      }

      context 'when adventure creation is successful' do
        response '201', 'Adventure created successfully' do
          let(:user_id) { 2 }

          it 'returns a 201 status' do
            run_test!
          end

          it 'returns the expected response schema' do
            {
              type: :object,
              properties: {
                message: { type: :string },
                adventures: adventures_schema
              },
              required: %w[message adventures]
            }
          end
        end
      end

      context 'when adventure creation encounters an error' do
        response '204', 'Adventure creation error.' do
          let(:user_id) { 2 }

          it 'returns a 204 status' do
            run_test!
          end

          it 'returns the expected error message' do
            expect(JSON.parse(response.body)['message']).to eq('Expected Error Message')
          end
        end
      end
    end
  end
end
