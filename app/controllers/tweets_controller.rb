class TweetsController < ApplicationController

  before_action :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    render :nothing => true, :status => 406
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to :home, notice: 'Tweeted' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { redirect_to :home, notice: 'Failed to Tweet'}
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
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
      params.require(:tweet).permit(:message)
    end
end
