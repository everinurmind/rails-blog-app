require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User Index Page', type: :feature do
  describe 'index page' do
    before(:each) do
      User.create(name: 'John Doe', photo: 'image1')
      User.create(name: 'Jane Smith', photo: 'image2')
    end

    let(:users) { User.all }

    it 'shows the right content' do
      visit users_path

      users.each do |user|
        expect(page).to have_content(user.name)
        # Verify that the username of each user is displayed
      end
    end

    it 'displays profile pictures for each user' do
      visit users_path

      users.each do |user|
        if user.photo.present?
          expect(page).to have_css("img[src*='#{user.photo}']")
          # Verify that the profile picture for each user is displayed
        else
          expect(page).not_to have_css('img.image')
          # Verify that there is no image tag for users without a profile picture
        end
      end
    end

    it 'displays the number of posts written by each user' do
      User.first.update(posts_counter: 5)
      User.last.update(posts_counter: 10)

      visit users_path

      expect(page).to have_content('5 posts written')
      expect(page).to have_content('10 posts written')
      # Verify that the number of posts for each user is displayed
    end

    it 'redirects to user show page when user is clicked' do
      visit users_path

      users.each do |user|
        click_link user.name
        expect(page).to have_current_path(user_path(user))
        # Verify that clicking on a user redirects to that user's show page
        visit users_path
      end
    end
  end
end
