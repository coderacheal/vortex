require 'rails_helper'
RSpec.describe User, type: :feature do
  before :each do
    @user = User.create(name: 'Racheal', photo: 'a photo of me',
                        bio: 'I am a software engineer', posts_counter: 0)
    @post_one = Post.create(author: @user, title: 'Still testing Capybara', text: 'Its been eye opening',
                            comments_counter: 3, likes_counter: 0)
    @post_two = Post.create(author: @user, title: 'Welcome to a bright day',
                            text: 'I love the smell of rain and fresh earth', comments_counter: 3, likes_counter: 1)
    @post_three = Post.create(author: @user, title: 'Love is in the air',
                              text: 'Integration test with Capybara and Selenium web drivers',
                              comments_counter: 3, likes_counter: 7)
    @post_four = Post.create(author: @user, title: 'Half of a yellow sun', text: 'Written by Chimamanda Ngozi Adichie',
                             comments_counter: 3, likes_counter: 10)
  end

  describe 'User index page' do

    it 'should check the username of all users' do
      visit users_path
      expect(page).to have_content(@user.name)
    end

    it 'should check the photo of the user' do
      visit users_path
      expect(page).to have_content(@user.photo)
    end
    it 'should check the number of post for the user' do
      visit users_path
      expect(page).to have_content(@user.posts_counter = 4)
    end
  end
  describe 'specific user show page' do
    it 'should check for user photo' do
      visit user_path(@user.id)
      expect(page).to have_css('div', text: @user.photo)
    end
    it 'should check for user name' do
      visit user_path(@user.id)
      expect(page).to have_css('h1', text: @user.name)
    end
    it 'should check for the user\'s image' do
      visit user_path(@user.id)
      expect(page).to have_content(@user.photo)
    end

    it 'should check for number of post' do
      visit user_path(@user.id)
      expect(page).to have_content('Number of posts:')
    end

    it 'should check for users bio' do
      visit user_path(@user.id)
      expect(page).to have_content(@user.bio)
    end

    it 'should check for posts body' do
      visit user_path(@user.id)
      expect(page).to have_css('p', text: 'Integration test with Capybara and Selenium web drivers')
    end
    it 'should check for the first 3 posts' do
      @all_posts = []
      @all_posts << @post_one
      @all_posts << @post_two
      @all_posts << @post_three
      @recent_posts = @all_posts.first(3)
      visit user_path(@user.id)
      expect(@post_one.text).to have_content('Its been eye opening')
      expect(page).to have_content(@post_two.likes_counter)
      expect(@post_three.likes_counter).to eq(7)
      expect(@recent_posts.count).to eq(3)
    end
    it 'should check for users bio' do
      visit user_path(@user.id)
      expect(page).to have_link('See all posts')
    end

    it 'should redirect to the post show page' do
      @post_four = Post.create(author: @user, title: 'Half of a yellow sun',
                               text: 'Written by Chimamanda Ngozi Adichie', comments_counter: 3, likes_counter: 10)
      visit user_path(@user.id)
      click_link 'Post 1'
      expect(page).to have_current_path(user_post_path(@user.id, @post_four.id))
    end

    it 'should redirect to the post index page' do
      visit user_path(@user.id)
      click_link 'Post 1'
      expect(page).to have_current_path(user_path(@user.id, @posts))
    end

  end
end
