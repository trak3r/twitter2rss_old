module Twitter
  class Base
    def merged_timeline(options={})
      tl = timeline(:friends, options)
      dm = direct_messages(options)
      (tl+dm).sort{|a,b|Date.parse(a.created_at) <=> Date.parse(b.created_at)}
    end
  end
end