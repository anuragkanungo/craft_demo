class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

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
end
