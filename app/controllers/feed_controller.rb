class FeedController < ApplicationController
  session :off
  layout nil
  
  def index
    @user = User.find_by_feed_guid(params[:guid])
    @watches = @user.watches
    
    respond_to do |format|
      format.atom
    end
  end
end