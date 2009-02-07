class Tweeter < ActiveRecord::Base
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name
end
