require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string
    get 'Retrieves all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'OK' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              text: { type: :string },
              author_id: { type: :integer },
              created_at: { type: :string },
              updated_at: { type: :string }
            },
            required: %w[id title text author_id created_at updated_at]
          }

        let(:user_id) { create(:user).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id: user_id)}" }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{id}' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'id', in: :path, type: :integer
    get 'Retrieves a specific post for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'OK' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :string },
            author_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[id title text author_id created_at updated_at]

        let(:user_id) { create(:user).id }
        let(:id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id: user_id)}" }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string
    post 'Creates a post for a user' do
      tags 'Posts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: %w[title text]
      }

      response '201', 'Created' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :string },
            author_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[id title text author_id created_at updated_at]

        let(:user_id) { create(:user).id }
        let(:post) { { title: 'Test Post', text: 'This is a test post.' } }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id: user_id)}" }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
          properties: {
            error: { type: :string }
          },
          required: %w[error]

        let(:user_id) { create(:user).id }
        let(:post) { { title: '', text: '' } }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id: user_id)}" }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{id}' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'id', in: :path, type: :integer
    delete 'Deletes a specific post for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '204', 'No Content' do
        let(:user_id) { create(:user).id }
        let(:id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id: user_id)}" }
        run_test!
      end
    end
  end
end
