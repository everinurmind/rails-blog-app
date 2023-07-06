 require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts/:id' do
    let!(:user) { User.create(name: 'John Doe') }
    let!(:post) { Post.create(author: user, title: 'Post 1', text: 'This is post 1') }
    let!(:like) { Like.create(author: user, post:, user_id: user.id) }
    before { get "/users/#{user.id}/posts/#{post.id}" }
    it 'displays the user\'s username' do
      expect(response.body).to include(user.name)
    end
    it 'displays the number of posts the user has written' do
      expect(response.body).to include(user.posts.count.to_s)
    end
    it 'displays the post\'s title' do
      expect(response.body).to include(post.title)
    end
    it 'displays some of the post\'s body' do
      expect(response.body).to include(post.text)
    end
    it 'displays the first comments on a post' do
      comment1 = Comment.create(author: user, post:, text: 'Comment 1')
      comment2 = Comment.create(author: user, post:, text: 'Comment 2')
      comments = post.comments
      expect(comments[0].text).to include(comment1.text)
      expect(comments[1].text).to include(comment2.text)
    end
    it 'displays how many comments a post has' do
      Comment.create(author: user, post:, text: 'Comment 1')
      Comment.create(author: user, post:, text: 'Comment 2')
      expect(response.body).to include(post.comments.count.to_s)
    end
    it 'displays how many likes a post has' do
      expect(response.body).to include(post.likes.count.to_s)
    end
  end
end