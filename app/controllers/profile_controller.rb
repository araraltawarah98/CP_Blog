class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.friendly.find(params[:id])
    @user_blogs = @user.blogs
  end
end
