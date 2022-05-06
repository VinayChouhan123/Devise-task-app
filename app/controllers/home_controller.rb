class HomeController < ApplicationController

  def index
    @users = User.all
    @posts = Post.all
  end

  def users
    @users = User.all
    @profiles = Profile.all
  end

end
