class HomeController < ApplicationController
  def index
    @tweet = current_user.tweets.build
    @feed_items = Tweet.all.paginate(page: params[:page])
  end

  def users
    @users = User.all
  end
end
