xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Tweets for #{@tweeter.screen_name}"
    xml.description "Tweets for #{@tweeter.screen_name}"
    for tweet in @tweeter.tweets(params[:password])
      xml.item do
        xml.title "#{screen_name(tweet)}"
        image = "#{image_tag(profile_image_url(tweet))}&nbsp;" if profile_image_url(tweet)
        xml.description "#{image}#{tweet.text}"
        xml.pubDate "#{Date.parse(tweet.created_at).to_s(:rfc822)}"
        xml.link "http://twitter.com/#{screen_name(tweet)}/status/#{tweet.id}" unless direct_message?(tweet)
        xml.guid "twitter2rss_#{tweet.id}"
      end
    end
  end
end

#<Twitter::Status:0x1a03d58
#  @user=#<Twitter::User:0x19c5760
#    @url="http://chadfowler.com",
#    @description="programmer and musician",
#    @profile_image_url="http://s3.amazonaws.com/twitter_production/profile_images/56201336/chadfowler_normal.jpg",
#    @name="Chad Fowler",
#    @followers_count="2512",
#    @protected=false,
#    @location="all over",
#    @id="790205",
#    @screen_name="chadfowler">,
# in_reply_to_status_id"",
# truncatedfalse,
# favoritedfalse,
# created_at"Sat Feb 07 05:35:12 +0000 2009",
# id"1185649986",
# in_reply_to_user_id"",
# source"&lt;a href=&quot;http://iconfactory.com/software/twitterrific&quot;&gt;twitterrific&lt;/a&gt;",
# text"I wonder if by the time A Love Supreme came out John Coltrane was embarrassed about Giant Steps."

#<Twitter::DirectMessage:0x23d8a18
# @sender_id="14585522",
# @recipient_screen_name="teflonted",
# @sender_screen_name="kanook",
# @created_at="Fri Jan 16 15:00:38 +0000 2009",
# @id="51225600",
# @recipient_id="845611",
# @text="I think it's called \"fellatio\"">
