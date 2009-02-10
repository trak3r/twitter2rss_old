class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def tweets(password)
    twitter = Twitter::Base.new(self.screen_name, password)
    _tweets = twitter.merged_timeline(:count => 100)
    update_attribute(:last_polled_at, Time.now) if (_tweets && _tweets.last)
    _tweets
  end
end
