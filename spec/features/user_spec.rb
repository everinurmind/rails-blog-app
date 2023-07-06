require 'rails_helper'
RSpec.describe 'Users', type: :request do
  describe 'GET /users/:id' do
    let!(:user) { User.create(name: 'John Doe') }
    let!(:post1) { Post.create(author: user, title: 'Post 1', text: 'This is post 1') }
    let!(:post2) { Post.create(author: user, title: 'Post 2', text: 'This is post 2') }
    let!(:post3) { Post.create(author: user, title: 'Post 3', text: 'This is post 3') }
    before { get "/users/#{user.id}" }
    it 'displays the user\'s username' do
      expect(response.body).to include(user.name)
    end
    it 'displays the user\'s first 3 posts' do
      expect(response.body).to include(post1.title)
      expect(response.body).to include(post2.title)
      expect(response.body).to include(post3.title)
    end
    it 'displays a button to view all user\'s posts' do
      expect(response.body).to include(user_posts_path(user))
    end
  end
end