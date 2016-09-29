require 'will_paginate/array'
class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_filter :authenticate_user!, :only => :all

  def feed
    respond_to do |format|
      @target_user = User.find(current_user.id)
      @tweets = feed_for(@target_user).paginate(:page => params[:page], :per_page => 100)
      format.json do
        render json: @tweets
      end

      format.html do
        render :feed
      end
    end
  end

  def user
    @target_user = User.find(params[:id])
    @tweets = @target_user.tweets.paginate(:page => params[:page], :per_page => 100)
    @user_feed = true
    render :feed
  end

  def all
    @tweets = Tweet.all
     render json: @tweets[0..100]
  end

  def new
    @tweet = Tweet.new(user_id: current_user.id)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to :back, notice: 'Tweeted' }
        format.json { redirect_to :back, notice: 'Tweeted'}
      else
        format.html { redirect_to :back, notice: 'Failed to Tweet'}
        format.json { redirect_to :back, notice: 'Failed to Tweet'}
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Tweet deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def tweet_params
      params.permit(:message)
    end

    def feed_for(user)
      feed = []
      user.following.each { |following| feed.concat(following.tweets) }
      feed
    end
end
