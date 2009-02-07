xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Tweets"
    xml.description "Lots of tweets"
#    xml.link formatted_articles_url(:rss)
#    for article in @articles
#      xml.item do
#        xml.title article.name
#        xml.description article.content
#        xml.pubDate article.created_at.to_s(:rfc822)
#        xml.link formatted_article_url(article, :rss)
#        xml.guid formatted_article_url(article, :rss)
#      end
#    end
  end
end