require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User Show Page', type: :feature do
  let!(:user) { User.create(name: 'John Doe', photo: 'image1', bio: 'A short bio about John Doe') }

  before(:each) do
    5.times do |i|
      Post.create(author: user, title: "Post #{i}", text: "Text for Post #{i}")
    end
    visit user_path(user)
  end

  it "shows the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it "shows the user's name" do
    expect(page).to have_content(user.name)
  end

  it "displays the number of posts the user has written" do
    expect(page).to have_content("Number of Posts: #{user.posts.count}")
  end

  it "shows the user's bio" do
    expect(page).to have_content(user.bio)
  end

  it "shows the user's first 3 posts" do
    user.posts.order(created_at: :desc).first(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'does not show more than 3 posts' do
    user.posts.order(created_at: :desc)[3..].each do |post|
      expect(page).not_to have_content(post.title)
    end
  end

  it "shows a button to view all of the user's posts" do
    expect(page).to have_link('Show All Posts', href: user_posts_path(user))
  end

  it "redirects to a post's show page when its title is clicked" do
    first_post = user.posts.order(created_at: :desc).first
    click_link first_post.title
    expect(page).to have_current_path(user_post_path(user, first_post))
  end

  it "redirects to the user's posts index page when the 'Show All Posts' button is clicked" do
    click_link 'Show All Posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
