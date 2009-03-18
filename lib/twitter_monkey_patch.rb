module Twitter
  class Base

    # TODO: monkey-patch this into ActionView::Helpers::TextHelper.auto_link
    def self.auto_link_ats(text)
      text.gsub(/(^|\s)@([A-Za-z0-9]+)/,'\1<a href="http://twitter.com/\2">@\2</a>')
    end  
    
    def merged_timeline(options={})
      tl = timeline(:friends, options)
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

    def already_following?(result)
      unless @friends_list
        @friends_list = []
        friends.each do |friend|
          @friends_list << friend.screen_name
        end
      end
      @friends_list.include?(result.from_user)
    end
    
    def is_reply?(result)
      result.text.starts_with?("@#{screen_name}")
    end

    def screen_name
      @config[:email]
    end

  end
end