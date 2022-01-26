# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    # This will force a redirect if the user has not created a profile - however this will break quite a lot of tests! Please add and then fix the tests by creating a profile after signing up 
    # unless current_user.profiles.exists?
    #   redirect_to '/'
    # end
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id]) if params[:id] != 'new'
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    # @post = Post.create(post_params)
    @post = @user.posts.create(post_params)
    redirect_to posts_url
  end

  #   def show
  #     @post = Post.find(params[:id])
  #   end

  private

  def post_params
    # unless Rails.env.test?
    #   path = post_params[:image].tempfile.path
    #   ImageProcessing::MiniMagick.source(path)
    #     .resize_to_limit(400, 400)
    #     .call(destination: path)
    # end
    params.require(:post).permit(:message, :image)
  end
end
