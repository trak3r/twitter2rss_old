require 'test_helper'

class TweeterTest < ActiveSupport::TestCase

  test "junk and stuff" do
    token = Tweeter.encode('teflonted', 'donthackme')
    screen_name, password = Tweeter.decode token
    assert_equal screen_name, 'teflonted'
    assert_equal password, 'donthackme'
  end
  
end
