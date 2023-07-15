class User < ApplicationRecord
  # A user has may posts,
  # A user can like many posts
  # A user can make many comments

  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  after_save :update_post_counter

  def return_top_three
    posts.order(created_at: :desc).limit(3)
  end

  private

  def update_post_counter
    update(posts_counter: posts_counter.count)
  end
end

module ApplicationCable
  class Connection < ActionCable::Connection::Base
  end
end
