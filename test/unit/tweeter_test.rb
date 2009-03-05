require 'test_helper'

class TweeterTest < ActiveSupport::TestCase

  test "un-html escape" do
    assert_equal '1<2', TweetHelper.un_h('1&lt;2')
    assert_equal '1>2', TweetHelper.un_h('1&gt;2')
    assert_equal '1"2', TweetHelper.un_h('1&quot;2')
  end

  test "junk and stuff" do
    plain_screen_name = 'fifteencharctrs'
    plain_password = 'howlongistoolong'
    token = Tweeter.encode(plain_screen_name, plain_password)
    puts "http://twitter2rss.anachromystic.com/#{token}.rss"
    decoded_screen_name, decoded_password = Tweeter.decode token
    assert_equal plain_screen_name, decoded_screen_name
    assert_equal plain_password, decoded_password
  end
  
end
