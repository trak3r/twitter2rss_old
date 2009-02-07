require File.dirname(__FILE__) + '/../test_helper'

class TimelineTest < ActiveSupport::TestCase
  def test_merged_timeline
    twitter = Twitter::Base.new('teflonted', 'donthackme')
    tweets = twitter.merged_timeline
    p tweets.first
    p tweets.last
  end
end