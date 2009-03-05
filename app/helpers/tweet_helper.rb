module TweetHelper

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
    tweet.kind_of?(Twitter::DirectMessage)
  end

  def reference?(tweet)
    tweet.kind_of?(Twitter::SearchResult)
  end

  def formatted(text)
    "<span style=\"font-size:medium\">#{TweetHelper.un_h(text)}</span>"
  end
  
  def avatar(tweet)
    if direct_message?(tweet)
      url = lookup_avatar(tweet.sender_id)
    elsif reference?(tweet)
      url = tweet.profile_image_url
    else
      url = profile_image_url(tweet)
    end
    "#{image_tag(url, {:align => 'left', :style => 'padding-right:5px'})}"
  end

  def profile_image_url(tweet)
    tweet.user.profile_image_url rescue nil
  end

  def screen_name(tweet)
    tweet.user.screen_name rescue tweet.sender_screen_name rescue tweet.from_user
  end

  private

  def lookup_avatar(id)
    # TODO: memoize me
    @twitter.user(id).profile_image_url rescue 'http://static.twitter.com/images/default_profile_normal.png'
  end

  class << self
    def un_h(text)
      text.gsub('&lt;', '<').gsub('&gt;', '>')
    end
  end
end
