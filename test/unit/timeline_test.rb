require File.dirname(__FILE__) + '/../test_helper'

class TimelineTest < ActiveSupport::TestCase
  def test_merged_timeline
    t = Twitter::Base.new('teflonted', 'donthackme')
    assert t.timeline
    assert t.direct_messages
    assert t.merged_timeline
  end
end