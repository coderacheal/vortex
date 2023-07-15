class User < ApplicationRecord
  # A user has may posts,
  # A user can like many posts
  # A user can make many comments

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  def return_top_three
    posts.order(created_at: :desc).limit(3)
  end
end
