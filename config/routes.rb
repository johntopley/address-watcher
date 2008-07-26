ActionController::Routing::Routes.draw do |map|
  map.root    :controller => 'watches'
  map.signin  '/signin',  :controller => 'session', :action => 'new'
  map.signout '/signout', :controller => 'session', :action => 'destroy'
  map.signup  '/signup',  :controller => 'users', :action => 'new'
  map.feed    '/watches/:guid.atom', :controller => 'feed', :action => 'index'
  map.configure_sms '/configure-sms', :controller => 'users', :action => 'edit'
  map.test_sms '/test-sms', :controller => 'tweets', :action => 'create'
  
  map.resources :users
  map.resource :session, :controller => 'session'
  map.resources :watches, :collection => { :delete => :delete }
end