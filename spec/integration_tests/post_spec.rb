require 'rails_helper'

RSpec.describe Post, type: :system do
  before :each do
    @user = User.create(name: 'Ama', photo: 'https://cdn-images-1.medium.com/max/1000/0*l1JFDNkMme1KAiwx',
                        bio: 'A girl who codes', posts_counter: 0)

    @post = Post.create(author: @user, title: 'First post',
                        text: 'Today is a great day. I had the day to do a lot of my Microverse work',
                        comments_counter: 0, likes_counter: 2)

    @comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'I am still on this testing')
  end

  describe '- User post index page' do
    it 'should display the user\'s profile picture' do
      visit user_posts_path(@user.id, @posts)
      expect(page).to have_content('https://cdn-images-1.medium.com/max/1000/0*l1JFDNkMme1KAiwx')
    end

    it 'should display the username ' do
      visit user_posts_path(@user.id, @posts)
      expect(page).to have_content('Ama')
    end

    it 'should display the number of posts the user has written ' do
      visit user_posts_path(@user.id, @posts)
      expect(@user.posts_counter).to eq(1)
    end

    it 'should display the post\'s title ' do
      visit user_posts_path(@user.id, @posts)
      expect(page).to have_content('First post')
    end

    it 'should check for the post\'s body' do
      visit user_posts_path(@user.id, @posts)
      expect(page).to have_content(@post.text)
    end

    it 'should check for the first comment on a post' do
      visit user_posts_path(@user.id, @posts)
      expect(page).to have_content(@post.text)
    end

    it 'should check for how many likes a post has' do
      visit user_posts_path(@user.id, @posts)
      expect(@post.likes_counter).to eq(2)
    end

    it 'should redirect page' do
      visit user_posts_path(@user.id, @posts)
      click_link 'view post'
      expect(page).to have_current_path(user_post_path(@user.id, @post.id))
    end
  end

  describe '- User post show page' do
    it 'should show post title' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Today is a great day. I had the day to do a lot of my Microverse work')
    end

    it 'should author of post' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.author.name)
    end

    it 'should show how many likes it has' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should show how many likes it has' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@post.text)
    end

    it 'should have the username of each commenter' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@comment.author.name)
    end

    it 'should show comment left by the commenter' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@comment.text)
    end
  end
end

# I can see the post's title.
# I can see who wrote the post.
# I can see how many comments it has.
# I can see how many likes it has.
# I can see the post body.
# I can see the username of each commentor.
# I can see the comment each commentor left.