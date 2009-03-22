class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def tweets(twitter)
    _tweets = twitter.merged_timeline
    update_attribute(:last_polled_at, Time.now) if (_tweets && _tweets.last)
    _tweets
  rescue Exception => e
    dm = Twitter::DirectMessage.new
    dm.text = "Twitter2RSS received the following error from the Twitter API:<br/>\"#{e.message}\"<br/>"
    dm.id = "#{Time.now.strftime('%Y%j%M%S')}"
    dm.sender_id = '21152730' # @tweets2rss
    dm.recipient_id = '-1'
    dm.sender_screen_name = 'tweets2rss'
    dm.recipient_screen_name = self.screen_name
    dm.created_at = "#{Time.now}"
    [dm]
  end

  class << self

    TOKEN = "-xyzzy-"
    
    def encode(screen_name, password)
      public_key.encrypt([screen_name, password].join(TOKEN))
    end

    def decode(encoded)
      private_key.decrypt(encoded).split(TOKEN)
    end

    def public_key
      Crypto::Key.from_file('rsa_key.pub')
    end

    def private_key
      Crypto::Key.from_file('rsa_key')
    end
    
  end
end
