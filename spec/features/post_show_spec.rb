require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post Show Page', type: :feature do
  let!(:user) { User.create(name: 'John Doe') }
  let!(:post) { Post.create(author: user, title: 'Sample Post', text: 'This is a sample post.') }

  before(:each) do
    3.times do |i|
      user.comments.create(post:, text: "Comment #{i}")
    end

    visit user_post_path(user, post)
  end

  it "displays the post's title" do
    expect(page).to have_content(post.title)
  end

  it "displays the post's author" do
    expect(page).to have_content(post.author.name)
  end

  it 'displays the number of comments the post has' do
    expect(page).to have_content("#{post.comments.count} comments")
  end

  it 'displays the number of likes the post has' do
    expect(page).to have_content("#{post.likes.count} likes")
  end

  it "displays the post's body" do
    expect(page).to have_content(post.text)
  end

  it 'displays the username of each commentor' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'displays the comment left by each commentor' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
