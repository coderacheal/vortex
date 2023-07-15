class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  belongs_to :author, class_name: 'User'

  # The 5 most recent comments for a given post

  after_save :update_posts_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  # Updates the post counter for a post
  private

  def update_posts_count
    author.increment!(:posts_counter)
  end
end
