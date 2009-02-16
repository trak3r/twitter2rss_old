class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def tweets(twitter)
    _tweets = twitter.merged_timeline(:count => 66)
    update_attribute(:last_polled_at, Time.now) if (_tweets && _tweets.last)
    _tweets
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
