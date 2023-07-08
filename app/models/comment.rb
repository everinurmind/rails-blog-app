class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  after_create :increment_comments_counter
  after_destroy :update_comment_counter

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
