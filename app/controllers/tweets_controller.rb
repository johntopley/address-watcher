class TweetsController < ApplicationController
  before_filter :login_required
  
  def create
    if current_user.sms_configured?
      username = current_user.twitter_username
      password = current_user.twitter_password
      Twitter::Base.new(username, password).post('Congratulations! Address Watcher is now able to send you SMS updates using Twitter.')
      flash[:notice] = 'SMS message sent'
    end
    redirect_to configure_sms_path
  rescue NoMethodError
    flash[:notice] = 'Unable to send SMS. Are your Twitter username and password correct?'
    redirect_to configure_sms_path
  end
end