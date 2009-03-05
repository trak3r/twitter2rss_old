module Twitter
  class Base
    
    def merged_timeline(options={})
      tl = timeline(:friends, options)
      dm = direct_messages(options)
      rf = references
      (tl+dm+rf).sort{|b,a|Date.parse(a.created_at) <=> Date.parse(b.created_at)}
    end

    def references
      filtered = []
      Twitter::Search.new("@#{screen_name}").per_page(100).each do |result|
        # don't include @replies
        filtered << result unless result.text.starts_with?("@#{screen_name}")
      end
      filtered
    end

    private

    def screen_name
      @config[:email]
    end

  end
end