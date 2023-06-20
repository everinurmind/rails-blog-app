require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  subject { Post.new(title: 'Hello', author: user, comments_counter: 3, likes_counter: 5) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with a title exceeding 250 characters' do
    subject.title = 'a' * 251
    expect(subject).not_to be_valid
  end

  it 'is not valid with a negative comments counter' do
    subject.comments_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid with a zero comments counter' do
    subject.comments_counter = 0
    expect(subject).to be_valid
  end

  it 'is not valid with a negative likes counter' do
    subject.likes_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid with a zero likes counter' do
    subject.likes_counter = 0
    expect(subject).to be_valid
  end
end
