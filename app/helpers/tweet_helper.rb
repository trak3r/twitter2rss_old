module TweetHelper
  def reply?(tweeter, tweet)
    tweet.text.include?("@#{tweeter.screen_name}")
  end

  def formatted(text)
    "<span style=\"font-size:x-large\">#{text}</span>"
  end
  
  def avatar(tweet)
    if profile_image_url(tweet)
      "#{image_tag(profile_image_url(tweet), {:align => 'left', :style => 'padding-right:16px'})}"
    else
      ''
    end
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
end
