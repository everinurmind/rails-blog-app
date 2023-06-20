require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(title: 'Hello', author: user) }
  subject { Like.new(author: user, post:) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an author' do
    subject.author = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).not_to be_valid
  end
end
