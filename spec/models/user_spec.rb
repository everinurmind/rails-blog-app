require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', posts_counter: 2) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with a negative posts counter' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid with a zero posts counter' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end
end
