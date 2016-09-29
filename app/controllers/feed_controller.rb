require 'will_paginate/array'
class FeedController < ApplicationController
  def index
    @target_user = User.find(current_user.id)
    @tweets = feed_for(@target_user).paginate(:page => params[:page], :per_page => 100)
    render :feed
  end

  def user
    @target_user = User.find(params[:id])
    @tweets = @target_user.tweets.paginate(:page => params[:page], :per_page => 100)
    @user_feed = true
    render :feed
  end

  private

  def feed_for(user)
    feed = []
    user.following.each { |following| feed.concat(following.tweets) }
    feed
  end
end
