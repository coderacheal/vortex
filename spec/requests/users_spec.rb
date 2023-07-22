require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before do
    @user = User.create(id: 745, name: 'John Doe', photo: 'htttp://myphotos.com', bio: 'Software')
  end

  describe 'GET /index' do
    it 'returns a success response' do
      get '/users/'
      expect(response).to be_successful
    end

    it 'renders the index template of views/users' do
      get '/users/'
      expect(response).to render_template(:index)
    end
  end
  it 'includes the correct placeholder text' do
    get '/users/'
    result = response.body
    expect(result).to include('Here is a list of users for this blog')
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get '/users/745'
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get '/users/745'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      get '/users/745'
      result = response.body
      expect(result).to include('Here is the details page for this user')
    end
  end
end
