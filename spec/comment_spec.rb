require 'rails_helper'

RSpec.describe Comment, type: :model do
  comment = Comment.new(author_id: 112, post_id: 1, text: 'I love waakye')

  it 'check the id of the author' do
    expect(comment.author_id).to eql 112
  end

  it 'check the id of the post' do
    expect(comment.post_id).to eql 1
  end

  it 'check the exact post that was made' do
    expect(comment.text).to eql('I love waakye')
  end

  it 'checks counts the comment made on a post' do
    User.create(name: 'Racheal', photo: 'my photo', bio: 'Cottage core', posts_counter: 1)
    post = Post.create(author_id: 1, title: 'Rain', text: 'Today is classic', comments_counter: 1, likes_counter: 1)
    comment = Comment.create(author_id: 1, post_id: post.id, text: 'I know right')

    expect(post.comments_counter).to eq(1)
  end
end