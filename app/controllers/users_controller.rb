class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]

  def new
    redirect_to home_path unless APP_CONFIG['signup_enabled']
    @user = User.new
    if flash[:invalid_user]
      @user = flash[:invalid_user]
    end
  end

  def create
    redirect_to home_path and return unless APP_CONFIG['signup_enabled']
    cookies.delete :auth_token
    @user = User.create!(params[:user])
    self.current_user = @user
    redirect_back_or_default('/')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid => error
    flash[:invalid_user] = error.record
    redirect_to :back
  end
  
  def edit
    @user = current_user
    if flash[:invalid_user]
      @user = flash[:invalid_user]
    end
  end
  
  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    render :action => 'edit'
  rescue ActiveRecord::RecordInvalid => error
    flash[:invalid_user] = error.record
    render :action => 'edit'
  end
end