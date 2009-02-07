xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Tweets for #{@tweeter.screen_name}"
    xml.description "RSS feed of tweets for #{@tweeter.screen_name}"
#    xml.link formatted_articles_url(:rss)
    for tweet in @tweets
      xml.item do
        xml.title tweet.text
        xml.description tweet.text
        xml.pubDate Date.parse(tweet.created_at).to_s(:rfc822)
#        xml.link formatted_article_url(tweet, :rss)
#        xml.guid formatted_article_url(tweet, :rss)
      end
    end
  end
end