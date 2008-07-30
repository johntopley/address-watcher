class Alert < ActionMailer::Base
  def alert(user, watch, sent_at = Time.now)
    subject    'Address Watcher Alert Notification'
    recipients user.email
    from       'alert@addresswatcher.com'
    sent_on    sent_at
    body       :user => user, :watch => watch
  end
end