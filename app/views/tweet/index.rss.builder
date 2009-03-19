cache(cache_key(@tweeter, params[:password])) do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "Tweets for #{@tweeter.screen_name}"
      xml.description "Tweets for #{@tweeter.screen_name}"
      for tweet in @tweeter.tweets(@twitter)
        xml.item do
          xml.title "#{screen_name(tweet)}#{suffix(tweet)}"
          xml.link "http://twitter.com/#{screen_name(tweet)}/status/#{tweet.id}" unless direct_message?(tweet)
          xml.guid "twitter2rss_#{tweet.id}"
          xml.description do
            xml.cdata!("#{avatar(tweet)}#{formatted(tweet.text)}")
          end
          xml.pubDate DateTime.parse(tweet.created_at).strftime("%a, %d %b %Y %H:%M:%S EST") # rfc822
        end
      end
    end
  end
end
