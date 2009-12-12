class TweetController < ApplicationController
  def index
    @tweeter = Tweeter.find_or_create_by_screen_name(params[:screen_name])
    httpauth = Twitter::HTTPAuth.new(@tweeter.screen_name, params[:password])
    @twitter = Twitter::Base.new(httpauth)
  rescue Exception => e
    # if 'production' = Rails.env # heroku
      render :text => "#{e.message}<br/>#{e.backtrace.join('<br/>')}"
    # else
    #   raise e
    # end
  end
end
