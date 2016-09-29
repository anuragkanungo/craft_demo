class ConnectionsController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => :create

    def new
      current_user.follow!(User.find(connection_params[:followed_id]))
    end

    def create
      respond_to do |format|
        if current_user.follow!(User.find(connection_params[:followed_id]))
          format.html { redirect_to :home, notice: 'Following now' }
        else
          format.html { redirect_to :home, notice: 'Failed to start following'}
        end
      end
    end

    def destroy
      @connection = Connection.find_by(follower_id: current_user.id, followed_id: connection_params[:followed_id] )
      @connection.destroy
      respond_to do |format|
        format.html { redirect_to :home, notice: 'Stopped following' }
      end
    end

    private

    def connection_params
      params.permit(:followed_id, :_method, :authenticity_token)
    end
end
