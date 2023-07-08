require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'post_id', in: :path, type: :integer
    get 'Retrieves all comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id text author_id post_id created_at updated_at]
               }

        let(:user_id) { create(:user).id }
        let(:post_id) { create(:post, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id:)}" }
        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{post_id}/comments/{id}' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'post_id', in: :path, type: :integer
    parameter name: 'id', in: :path, type: :integer
    delete 'Deletes a specific comment for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response '204', 'No Content' do
        let(:user_id) { create(:user).id }
        let(:post_id) { create(:post, author_id: user_id).id }
        let(:id) { create(:comment, post_id:, author_id: user_id).id }
        let(:Authorization) { "Bearer #{JwtToken.encode(user_id:)}" }
        run_test!
      end
    end
  end
end
