class ConnectionsController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => :create

    def new
      current_user.follow!(User.find(connection_params[:followed_id]))
    end

    def create
      respond_to do |format|
        followed_user = User.find(connection_params[:followed_id])
        if current_user.follow!(followed_user)
          format.html { redirect_to :back, notice: "Following #{followed_user.email} now" }
        else
          format.html { redirect_to :back, notice: 'Failed to start following'}
        end
      end
    end

    def destroy
      @connection = Connection.find_by(follower_id: current_user.id, followed_id: connection_params[:followed_id] )
      @connection.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Stopped following' }
      end
    end

    private

    def connection_params
      params.permit(:followed_id, :_method, :authenticity_token)
    end
end
