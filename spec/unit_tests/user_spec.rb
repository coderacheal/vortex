require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @person = User.create(name: 'Racheal', photo: 'a photo of me',
                          bio: 'I am a software engineer')
  end

  describe 'validations' do
    it 'should validate the presence of name' do
      @person.name = nil
      expect(@person).to_not be_valid
    end

    it 'should validate that post count is an integer' do
      @person.posts_counter = '5'
      expect(@person).to_not be_valid
    end

    it 'should have posts > 0' do
      @person.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should have many posts' do
      expect(@person.posts).to eq([])
    end

    it 'should have many comments' do
      expect(@person.comments).to eq([])
    end

    it 'should have many likes' do
      expect(@person.likes).to eq([])
    end
  end

  describe 'recent posts by user' do
    it 'should return the 3 most recent posts' do
      5.times do |i|
        Post.create(author: @person, title: "Post #{i}", text: "Post #{i} body")
      end
      expect(@person.return_top_three).to eq(@person.posts.order(created_at: :desc).limit(3))
    end
  end
end
