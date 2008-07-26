# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  filter_parameter_logging :password
  
  # Disable sessions for robots. See The Rails Way p472
  session :off, :if => lambda { |req| req.user_agent =~ /(Google|Slurp)/i }

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'b3d3ea491b4473dea283ae0d3b601507'
  
  def rescue_action_in_public(exception)
    case exception
      when ActiveRecord::RecordNotFound, ActionController::UnknownController,
           ActionController::RoutingError, ActionController::UnknownAction
        render_404
      else
        render_500
        deliverer = self.class.exception_data
        data = case deliverer
          when nil then {}
          when Symbol then send(deliverer)
          when Proc then deliverer.call(self)
        end
        ExceptionNotifier.deliver_exception_notification(exception, self,
          request, data)
    end
  end
end