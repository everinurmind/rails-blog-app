require 'swagger_helper'

RSpec.describe 'Likes API', type: :request do
  path '/users/{user_id}/posts/{post_id}/likes' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'post_id', in: :path, type: :integer
    get 'Retrieves all likes for a post' do
      tags 'Likes'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id author_id post_id created_at updated_at]
               }

        let(:user_id) { create(:user).id }
        let(:post_id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id:)}" }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{post_id}/likes' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'post_id', in: :path, type: :integer
    post 'Creates a like for a post' do
      tags 'Likes'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '201', 'Created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 author_id: { type: :integer },
                 post_id: { type: :integer },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id author_id post_id created_at updated_at]

        let(:user_id) { create(:user).id }
        let(:post_id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id:)}" }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]

        let(:user_id) { create(:user).id }
        let(:post_id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id:)}" }
        run_test!
      end
    end
  end
end
