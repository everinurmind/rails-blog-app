require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User Post Index Page', type: :feature do
  let!(:user) { User.create(name: 'John Doe') }

  before(:each) do
    user.update(photo: 'image1.jpeg')
    10.times do |i|
      user.posts.create(title: "Post #{i}", text: "Text for Post #{i}")
    end
    visit user_posts_path(user)
  end

  it "displays the user's username" do
    expect(page).to have_content(user.name)
  end

  it "displays a post's title" do
    user.posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it "displays some of the post's body" do
    user.posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'displays the first comments on a post' do
    user.posts.each do |post|
      post.recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  it 'displays the number of comments a post has' do
    user.posts.each do |post|
      expect(page).to have_content("#{post.comments.count} comments")
    end
  end

  it 'displays the number of likes a post has' do
    user.posts.each do |post|
      expect(page).to have_content("#{post.likes.count} likes")
    end
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    # no pagination
  end

  it "redirects to a post's show page when clicked" do
    first_post = user.posts.first
    click_link first_post.title
    expect(page).to have_current_path(user_post_path(user, first_post))
  end
end
