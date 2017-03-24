require 'rubygems'
require './constants.rb'
require './fetch_tweet.rb'
require './process_tweet.rb'
require 'clockwork'
include Clockwork

last_id = 9 * 10**18
last_id = 842956231727812608

handler do |job|
  case job
  when 'regular-job'
    tweets, last_id = get_tweets_since(last_id)
    tweets.reverse_each do |tweet|
      process(tweet)
    end
  end
end


every(INTERVAL.seconds, 'regular-job')
