module TweetHelper

  def suffix(tweet)
    return " (@reply)" if reply?(@tweeter, tweet)
    return " (direct message)" if direct_message?(tweet)
    return ""
  end

  def reply?(tweeter, tweet)
    tweet.text.include?("@#{tweeter.screen_name}")
  end

  def formatted(text)
    "<span style=\"font-size:medium\">#{text}</span>"
  end
  
  def avatar(tweet)
    if profile_image_url(tweet)
      url = profile_image_url(tweet)
    else
      url = lookup_avatar(tweet.sender_id)
    end
    "#{image_tag(url, {:align => 'left', :style => 'padding-right:10px'})}"
  end

  def profile_image_url(tweet)
    tweet.user.profile_image_url rescue nil
  end

  def screen_name(tweet)
    tweet.user.screen_name rescue tweet.sender_screen_name
  end

  def direct_message?(tweet)
    tweet.kind_of?(Twitter::DirectMessage)
  end

  private

  def lookup_avatar(id)
    @twitter.user(id).profile_image_url
  end

end
