xml.instruct!
xml.feed("xml:lang" => 'en', "xmlns" => 'http://www.w3.org/2005/Atom') do
  xml.title("Watches For #{@user.name} - Address Watcher", :type => :html)
  xml.link(:rel => 'self', :href => feed_url(@user.feed_guid))
  xml.link(:rel => 'alternate', :href => root_url)
  xml.updated(@user.watches_updated_at.xmlschema)
  xml.id("http://#{request.host}/")
  
  for watch in @watches
    xml.entry do
      xml.id("tag:#{request.host},#{watch.permalink}")
      xml.title(h(watch.name))
      xml.published(watch.created_at.xmlschema)
      xml.updated(watch.updated_at.xmlschema)
      xml.link(:rel => :alternate, :href => "#{h(watch.address)}")
      xml.content("#{watches_updated_on(@user)}. Expected HTTP #{watch.expected}, actual was #{watch.actual}.")
      
      xml.author do |author|
        author.name('Address Watcher')
      end
    end
  end
end