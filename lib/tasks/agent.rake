namespace :agent do
  desc 'Updates all watches for all users.'
  task :run => :environment do
    for user in User.all
      for watch in user.watches
        begin
          response = Net::HTTP.get_response(URI.parse(watch.address))
          watch.actual = response.code
        rescue SocketError
          watch.actual = nil
        end
        puts watch
        if watch.actual != watch.expected && watch.actual != 'N/A'
          if watch.alert_sent? == false
            if watch.sms? && user.sms_configured?
              puts "Sending alert SMS to #{user.twitter_username}."
              begin
                Twitter::Base.new(user.twitter_username, user.twitter_password).post(
                  "Address Watcher expected HTTP #{watch.expected} for #{watch.name}, but got HTTP #{watch.actual}.")
              
              # Couldn't send SMS - ignore
              rescue NoMethodError
              end
            end
            if watch.email?
              puts "Sending alert email to #{user.email}."
            end
            watch.alert_sent = true
          end
          
        # The actual equals the expected, so reset the alert_sent flag
        else
          watch.alert_sent = false
        end
        watch.save
        sleep 10
      end
      user.watches_updated_at = Time.now.utc
      user.save
    end
  end
end