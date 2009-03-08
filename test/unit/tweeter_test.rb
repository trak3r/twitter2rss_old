require 'test_helper'

class TweeterTest < ActiveSupport::TestCase

  test "encoding and decoding" do
    plain_screen_name = 'fifteencharctrs'
    plain_password = 'howlongistoolong'
    token = Tweeter.encode(plain_screen_name, plain_password)
    puts "http://twitter2rss.anachromystic.com/#{token}.rss"
    decoded_screen_name, decoded_password = Tweeter.decode token
    assert_equal plain_screen_name, decoded_screen_name
    assert_equal plain_password, decoded_password
  end
  
end
