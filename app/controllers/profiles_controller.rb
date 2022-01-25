# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:new, :create]

  def index
    @profiles = Profile.all
  end

  def edit
    @profile = Profile.find(current_user.id)
  end

  def update
    @profile = Profile.find(current_user.id)

    if @profile.update(profile_params)
      redirect_to user_profile_path(profile.user_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = User.find(current_user.id)
    end
    @profile = @user.profiles if params[:id] != 'new'
    @posts = Post.where(:user_id => current_user.id)
    @post_ids= []
    @posts.each do |post| @post_ids << post.id end
    @comments = Comment.where(:user_id => current_user.id)
    @comments.each do |comment| @post_ids << comment.post_id end
    @posts_to_use = Post.find((@post_ids.uniq.sort_by { |number| -number }))
  end

  def new
    @profile= Profile.new
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.profiles.create(profile_params)
    redirect_to user_profile_path
  end

  private

  def profile_params
    params.require(:profile).permit(:about, :avatar)
  end

  def check_for_existing_profile
    @user = User.find(current_user.id)
    @profile = Profile.where(:user_id => current_user.id)
    if @profile.exists?
      redirect_to posts_url, notice: "Logged in successfully"
    end
    rescue ActiveRecord::RecordNotFound => e
      return "Not Found"
  end
end
