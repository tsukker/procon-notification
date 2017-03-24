#coding: utf-8
require 'rubygems'
require 'twitter'
require './constants.rb'

# clientの設定
@cli = Twitter::REST::Client.new do |config|
  config.consumer_key        = TWITTER_CONSUMER_KEY
  config.consumer_secret     = TWITTER_CONSUMER_SECRET
  config.access_token        = TWITTER_ACCESS_TOKEN
  config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
end

def get_tweets_since(id)
  ar = @cli.user_timeline('tc_calendar_bot', since_id: id, count: 200, trim_user: true)
  new_id = 0
  if ar.size > 0
    new_id = ar[0].id
  else
    new_id = @cli.user_timeline('tc_calendar_bot', count: 1, trim_user: true)[0].id
  end
  [ar, new_id]
end

def check_tweet_time
  @cli.update("hello #{Time.now} ")
end
