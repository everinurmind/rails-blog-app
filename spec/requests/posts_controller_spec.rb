require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #show' do
    let(:user) { User.create(name: 'Test User') }
    let(:post) { Post.create(title: 'Test Post', author: user) }

    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include("<h2>Title: #{post.title}</h2>")
    end
  end
end
