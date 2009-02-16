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

    # {"text"=>"@teflonted does google reader have a ping service?",
    #  "to_user_id"=>67976,
    #  "to_user"=>"teflonted",
    #  "from_user"=>"dstarh",
    #  "id"=>1212260036,
    #  "from_user_id"=>21209,
    #  "iso_language_code"=>"en",
    #  "profile_image_url"=>"http://s3.amazonaws.com/twitter_production/profile_images/58119380/2732000806_c366667564_s_normal.jpg",
    #  "created_at"=>"Sun, 15 Feb 2009 13:20:52 +0000"}

    private

    def screen_name
      @config[:email]
    end

  end
end