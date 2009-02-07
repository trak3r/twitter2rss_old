class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def tweets(password)
    twitter = Twitter::Base.new(self.screen_name, password)
    _tweets = twitter.merged_timeline(:since => self.last_polled_at)
    if _tweets
      if _tweets.last
        self.last_polled_at = Date.parse(_tweets.last.created_at)
        save!
      end
    end
    _tweets
  end
end
