module WatchesHelper
  def delete_link(watch)
    confirm_text = "Are you sure you want to delete the ‘#{watch.name}’ watch?"
    link_to(image_tag('delete.png', :size => '16x16', :alt => 'Delete',
                                    :title => 'Delete'),
                       watch_path(watch), :method => :delete,
                                    :class => 'crud_link',
                                    :confirm => confirm_text)
  end
  
  def delete_all_link
    confirm_text = "Are you sure you want to delete all your watches?"
    link_to(image_tag('delete.png', :size => '16x16', :alt => 'Delete All',
                                    :title => 'Delete All'),
                       delete_watches_path, :method => :delete,
                                    :class => 'crud_link',
                                    :confirm => confirm_text)
  end
  
  def edit_link(watch)
    link_to(image_tag('edit.png', :size => '16x16', :alt => 'Edit',
                                  :title => 'Edit'),
                       edit_watch_path(watch), :class => 'crud_link')
  end
  
  def email_on(watch)
    image_tag('tick.png', :size => '16x16', :alt => '') if watch.email?
  end
  
  def feed_link
    href = feed_path(current_user.feed_guid)
    content = content_tag(:a, image_tag('feed_icon.png', :size => '16x16',
                                        :alt => 'Watches feed'),
                          :href => href)
    "#{content} #{link_to('Feed', href, :id => 'feedlink')}"
  end
  
  def format_actual(watch)
    if watch.actual != 'N/A' && watch.actual != watch.expected
      return "<span class=\"unexpected\">#{h(watch.actual)}</span>"
    end
    h(watch.actual)
  end
  
  def gravatar_image
    if Rails.env == 'production'
      gravatar_for(current_user, :size => 50,
                                 :default => APP_CONFIG['gravatar_default'])
    end
  end
  
  def sms_on(watch)
    image_tag('tick.png', :size => '16x16', :alt => '') if watch.sms?
  end
  
  def watches_updated_on
    last_updated = current_user.watches_updated_at.utc
    return 'First update pending' if last_updated.nil?
    "Updated #{time_ago_in_words(current_user.watches_updated_at.utc)} ago"
  end
end