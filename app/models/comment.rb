class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  after_create :increment_comments_counter

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
