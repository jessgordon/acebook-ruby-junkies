# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe PostsController, type: :controller do
  before(:each) do
    user = create(:user)
    sign_in user
  end
  describe 'GET /new ' do
    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      # user = create(:user)
      # sign_in user
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(response).to redirect_to(posts_url)
    end

    it 'creates a post' do
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(Post.find_by(message: 'Hello, world!')).to be
    end
  end

  describe 'GET /' do
    it 'responds with 302' do
      get :index
      expect(response).to have_http_status(302)
    end
  end
end
