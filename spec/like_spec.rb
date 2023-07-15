require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new(author_id: 1, post_id: 1)

  it 'return author id' do
    expect(like.author_id).to eql 1
  end

  it 'return post id' do
    expect(like.post_id).to eql 1
  end

  it '- updates the likes_counter' do
    User.create(name: 'Racheal', photo: 'my photo', bio: 'Cottage core', posts_counter: 3)
    post = Post.create(author_id: 1, title: 'New', text: 'First post', comments_counter: 3, likes_counter: 2)
    like = Like.create(author_id: 1, post_id: post.id)

    post.likes_counter = 2
    post.save
  end
end
