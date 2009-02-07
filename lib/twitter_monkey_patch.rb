module Twitter
  class Base
    def merged_timeline(options={})
      tl = timeline(:friends, options)
      dm = direct_messages(options)
      (tl+dm).sort{|a,b|a.created_at <=> b.created_at}
    end
  end
end