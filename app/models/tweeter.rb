class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def tweets(twitter)
    _tweets = twitter.merged_timeline(:count => 66)
    update_attribute(:last_polled_at, Time.now) if (_tweets && _tweets.last)
    _tweets
  end
end
