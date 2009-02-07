require 'test_helper'

class TweeterTest < ActiveSupport::TestCase
  test "last_polled_at" do
    password = 'donthackme'
    tweeter = Tweeter.find_or_create_by_screen_name('teflonted')
    first_poll = tweeter.tweets(password)
    assert !first_poll.empty?
    second_poll = tweeter.tweets(password)
    assert second_poll.empty?
  end
end
