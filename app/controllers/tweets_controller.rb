class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  # before_action :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    render :nothing => true, :status => 406
  end


  def new
    @tweet = Tweet.new(user_id: current_user.id)
  end
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to :home, notice: 'Tweeted' }
        format.json { redirect_to :home, notice: 'Tweeted'}
      else
        format.html { redirect_to :home, notice: 'Failed to Tweet'}
        format.json { redirect_to :home, notice: 'Failed to Tweet'}
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to :home, notice: 'Tweet deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def tweet_params
      params.permit(:message)
    end
end
