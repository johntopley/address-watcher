namespace :agent do
  desc 'Updates all watches for all users.'
  task :run => :environment do
    require 'timeout'
    require 'logger'
    logger = Logger.new("#{RAILS_ROOT}/log/agent.log", 5, 10 * 1024)
    
    for user in User.all
      for watch in user.watches
        begin
          Timeout::timeout(5) do
            response = Net::HTTP.get_response(URI.parse(watch.address))
            watch.actual = response.code
          end
        rescue Timeout::Error
          # puts "Request to #{watch.address} timed out."
          logger.warn "Request to #{watch.address} timed out."
          watch.actual = 'Timed Out'
        rescue SocketError => error
          # puts "SocketError whilst getting HTTP response for #{watch.address}: #{error}"
          logger.error "SocketError whilst getting HTTP response for #{watch.address}: #{error}"
          watch.actual = nil
        end
        
        # puts watch
        logger.info watch.to_s
        
        if watch.actual != watch.expected && (watch.actual != 'Pending' && watch.actual != 'Timed Out')
          if watch.alert_sent? == false
            if watch.sms? && user.sms_configured?
              # puts "Sending alert SMS to #{user.twitter_username}."
              logger.info "Sending alert SMS to #{user.twitter_username}."
              begin
                Twitter::Base.new(user.twitter_username, user.twitter_password).post(
                  "Address Watcher expected HTTP #{watch.expected} for #{watch.name}, but got HTTP #{watch.actual}.")
              
              # Couldn't send SMS - ignore
              rescue NoMethodError
                logger.error "Unable to send alert SMS to #{user.twitter_username}"
              end
            end
            if watch.email?
              # puts "Sending alert email to #{user.email}."
              logger.info "Sending alert email to #{user.email}."
              Alert.deliver_alert(user, watch)
            end
            watch.alert_sent = true
          end
          
        # The actual equals the expected, so reset the alert_sent flag
        else
          watch.alert_sent = false
        end
        
        watch.save
        sleep 5
      end
      
      user.watches_updated_at = Time.now.utc
      user.save
    end
  end
end