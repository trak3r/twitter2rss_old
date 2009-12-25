module TweetHelper

  def cache_key(tweeter, password)
    # http://stackoverflow.com/questions/449271/how-to-round-a-time-down-to-the-nearest-15-minutes-in-ruby
    t = Time.now
    "#{tweeter.screen_name}_#{(t-t.sec-t.min%15*60).strftime('%Y-%m-%d-%H-%M')}_#{password.hash}"
  end
  
  def suffix(tweet)
    return " (@reply)" if reply?(@tweeter, tweet)
    return " (direct message)" if direct_message?(tweet)
    return " (search result reference)" if reference?(tweet)
    return ""
  end

  def reply?(tweeter, tweet)
    tweet.text.starts_with?("@#{tweeter.screen_name}")
  end

  def direct_message?(tweet)
    !tweet.sender.nil? # tweet.kind_of?(Twitter::DirectMessage)
  end

  def reference?(tweet)
    false # tweet.kind_of?(Twitter::SearchResult)
  end

  def formatted(text)
    "<span style=\"font-size:medium\">#{Twitter::Base.auto_link_ats(auto_link(CGI::unescapeHTML(text.gsub('&amp;','&'))))}</span>"
  end
  
  def avatar(tweet)
    # if direct_message?(tweet)
    #   url = lookup_avatar(tweet.sender_id)
    # elsif reference?(tweet)
    #   url = tweet.profile_image_url
    # else
    #   url = profile_image_url(tweet)
    # end
    "#{image_tag(profile_image_url(tweet), {:align => 'left', :height => 48, :width => 48, :style => 'padding-right:5px'})}"
  end

  def profile_image_url(tweet)
    tweet.user.profile_image_url rescue tweet.sender.profile_image_url
  end

  def screen_name(tweet)
    begin
      tweet.user.screen_name # Status
    rescue 
      begin
        tweet.sender_screen_name # DirectMessage
      rescue 
        begin
          tweet.from_user # SearchResult
        rescue
          '?'
        end
      end
    end
  end

  # private
  # 
  # def lookup_avatar(id)
  #   @avatars ||= {}
  #   @avatars[id] ||= (@twitter.user(id).profile_image_url rescue 'http://static.twitter.com/images/default_profile_normal.png')
  # end
end
