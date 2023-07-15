require 'rails_helper'

RSpec.describe User, type: :model do
  post = Post.new(author_id: 1, title: 'Today is a good day', text: 'Cloudy days are the best', comments_counter: 5,
                  likes_counter: 10)

  it 'checks author id' do
    expect(post.author_id).to eq(1)
  end

  it 'title should not be null' do
    expect(post.title).to eq('Today is a good day')
  end

  it 'text should be valid' do
    expect(post.text).to eq('Cloudy days are the best')
  end

  it 'comment should be greater or equal to 0' do
    expect(post.comments_counter).to eq(5)
  end

  it 'has a valid number for likes counter' do
    expect(post.likes_counter).to eq(10)
  end

  it 'checks update_author_posts_counter' do
    user = User.create!(name: 'Racheal', posts_counter: 0)

    user.posts.create!(title: 'New Test', text: 'Who am I', comments_counter: 3, likes_counter: 2)
    user.posts.create!(title: 'New Test', text: 'Who am I', comments_counter: 3, likes_counter: 2)
    user.posts.create!(title: 'New Test', text: 'Who am I', comments_counter: 3, likes_counter: 2)
    user.posts.create!(title: 'New Test', text: 'Who am I', comments_counter: 3, likes_counter: 2)

    user.reload

    expect(user.posts_counter).to eq(4)
  end
end