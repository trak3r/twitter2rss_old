module Twitter
  class Base
    
    def merged_timeline(options={})
      tl = timeline(:friends, options)
      note_followings(tl)
      dm = direct_messages(options)
      rf = references
      (tl+dm+rf).sort{|b,a|Date.parse(a.created_at) <=> Date.parse(b.created_at)}
    end
    
    def references
      filtered = []
      Twitter::Search.new("@#{screen_name}").per_page(100).each do |result|
        filtered << result unless(is_reply?(result) || already_following?(result))
      end
      filtered
    end

    private

    def note_followings(tweets)
      tweets.each do |tweet|
        @followings ||= []
        @followings << tweet.user.screen_name
      end
    end
    
    def already_following?(result)
      @followings.include?(result.from_user)
    end
    
    def is_reply?(result)
      result.text.starts_with?("@#{screen_name}")
    end

    def screen_name
      @config[:email]
    end

  end
end