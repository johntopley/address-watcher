xml.instruct!
xml.feed("xml:lang" => 'en', "xmlns" => 'http://www.w3.org/2005/Atom') do
  xml.title("Watches For #{@user.name} - Address Watcher", :type => :html)
  xml.link(:rel => 'self', :href => feed_url(@user.feed_guid))
  xml.link(:rel => 'alternate', :href => root_url)
  xml.updated(@watches.first.updated_at.xmlschema)
  xml.id("http://#{request.host}/")
  
  for watch in @watches
    xml.entry do
      xml.id("tag:#{request.host},#{watch.permalink}")
      xml.title(h(watch.name))
      xml.published(watch.created_at.xmlschema)
      xml.updated(watch.updated_at.xmlschema)
      xml.link(:rel => :alternate, :href => "#{watch_url(watch.to_param)}")
      xml.content("#{@user.watches_updated_on}. Expected HTTP #{watch.expected}, actual was #{watch.actual}.")
      
      xml.author do |author|
        author.name('Address Watcher')
      end
    end
  end
end