require 'test_helper'

class TweeterTest < ActiveSupport::TestCase
  
  test "regex for linking @name's in tweets" do
    assert_equal '<a href="http://twitter.com/teflonted">@teflonted</a> was here', 
                 Twitter::Base.auto_link_ats('@teflonted was here')
    assert_equal 'was <a href="http://twitter.com/teflonted">@teflonted</a> here', 
                 Twitter::Base.auto_link_ats('was @teflonted here')
    assert_equal 'here was <a href="http://twitter.com/teflonted">@teflonted</a>', 
                 Twitter::Base.auto_link_ats('here was @teflonted')
    assert_equal 'teflonted@gmail.com', 
                 Twitter::Base.auto_link_ats('teflonted@gmail.com')
  end

  test "encoding and decoding" do
    plain_screen_name = 'fifteencharctrs'
    plain_password = 'howlongistoolong'
    token = Tweeter.encode(plain_screen_name, plain_password)
    # puts "http://twitter2rss.anachromystic.com/#{token}.rss"
    decoded_screen_name, decoded_password = Tweeter.decode token
    assert_equal plain_screen_name, decoded_screen_name
    assert_equal plain_password, decoded_password
  end
  
end
