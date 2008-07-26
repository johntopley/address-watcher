class WatchesController < ApplicationController
  before_filter :login_required
  before_filter :find_watch, :only => [:destroy, :edit, :update]
  
  def index
    @watches = Watch.find_all(current_user, params[:p])
    @watch = Watch.new(:address => 'http://', :expected => '200')
    if flash[:invalid_watch] && session[:edit_error].nil?
      @watch = flash[:invalid_watch]
    end
    session[:edit_error] = nil
  end
  
  def create
    @watch = current_user.watches.create!(params[:watch])
    redirect_to watches_path
  rescue ActiveRecord::RecordInvalid => error
    flash[:invalid_watch] = error.record
    redirect_to :back
  end
  
  def delete
    Watch.destroy_all
    redirect_to watches_path
  end
  
  def destroy
    @watch.destroy
    redirect_to watches_path
  end
  
  def update
    @watch.alert_sent = false # Must reset alert flag
    @watch.update_attributes!(params[:watch])
    redirect_to watches_path
  rescue ActiveRecord::RecordInvalid => error
    
    # Flag to stop validation errors being displayed on watches screen after
    # cancelling an edit with validation errors
    session[:edit_error] = true
    flash[:invalid_watch] = error.record
    render :action => 'edit'
  end
  
  private
  def find_watch
    @watch = Watch.find_by_permalink(current_user, params[:id])
    redirect_to watches_path and return if @watch.user != current_user
  end
end