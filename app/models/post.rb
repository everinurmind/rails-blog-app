class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_create :update_user_posts_counter

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
