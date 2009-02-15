class TweetController < ApplicationController
  def index
    @tweeter = Tweeter.find_or_create_by_screen_name(params[:screen_name])
    @twitter = Twitter::Base.new(@tweeter.screen_name, params[:password])
  end
end
