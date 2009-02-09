module TweetHelper
  def avatar(tweet)
    if profile_image_url(tweet)
      "#{image_tag(profile_image_url(tweet), {:align => 'left'})}"
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
