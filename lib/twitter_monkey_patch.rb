module Twitter
  class Base

    # TODO: monkey-patch this into ActionView::Helpers::TextHelper.auto_link
    def self.auto_link_ats(text)
      text.gsub(/(^|\s)@([A-Za-z0-9_]+)/,'\1<a href="http://twitter.com/\2">@\2</a>')
    end  
    
    def merged_timeline(options={})
      tl = []
      Tweeter.benchmark "timeline" do
        tl = timeline(:friends, {:count => 55}.merge(options))
      end
      dm = []
      Tweeter.benchmark "direct_messages" do
        dm = direct_messages({:count => 11}.merge(options))
      end
      rf = []
      Tweeter.benchmark "references" do
        rf = references
      end
      (tl+dm+rf).sort{|b,a|Date.parse(a.created_at) <=> Date.parse(b.created_at)}
    end
    
    def references
      filtered = []
      Twitter::Search.new("@#{screen_name}").per_page(11).each do |result|
        filtered << result unless(is_reply?(result) || already_following?(result))
      end
      filtered[0..20]
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