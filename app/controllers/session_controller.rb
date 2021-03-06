# This controller handles the login/logout function of the site.  
class SessionController < ApplicationController
  
  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token,
                :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = 'You have been signed in.'
    else
      flash.now[:error] = 'You could not be signed in. Did you enter the ' +
        'correct username and password?'
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = 'You have been signed out.'
    redirect_to watches_path
  end
end