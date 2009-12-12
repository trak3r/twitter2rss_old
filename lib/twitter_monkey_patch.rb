module Twitter
  class Base

    # TODO: monkey-patch this into ActionView::Helpers::TextHelper.auto_link
    def self.auto_link_ats(text)
      text.gsub(/(^|\s)@([A-Za-z0-9_]+)/,'\1<a href="http://twitter.com/\2">@\2</a>')
    end  
    
    def merged_timeline(options={})
      ft = []
      Tweeter.benchmark "friends_timeline" do
        ft = friends_timeline({:count => 55}.merge(options))
      end
      m = []
      Tweeter.benchmark "mentions" do
        m = mentions({:count => 55}.merge(options))
      end
      dm = []
      Tweeter.benchmark "direct_messages" do
        dm = direct_messages({:count => 11}.merge(options))
      end
      (ft + m + dm).sort{|b,a|Date.parse(a.created_at) <=> Date.parse(b.created_at)}
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