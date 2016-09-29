class UsersController < ApplicationController
  def followers
    @users = current_user.followers
  end

  def following
    @users = current_user.following
  end

  def everyone
    @users = User.all
  end

end
