require 'rubygems'
require 'twitter'
require 'slack'
require './constants.rb'

Slack.configure do |config|
  config.token = SLACK_TOKEN
end

def will_post(text)
  text.each_line do |line|
    if line.include?(CONTEST_TODAY) || line.include?(CONTEST_1HOUR) || line.include?(CONTEST_ADDED)
      if text.include?(CONTEST_ATCODER) || text.include?(CONTEST_CODEFORCES) || text.include?(CONTEST_TOPCODER)
        return true
      end
    end
    return false
  end
end

def post(tweet)
  channel_name = '#test_tsukker'
  channel_id = 'G4J0E3XD2'
  bot_name = 'procon-notify'
  post_text = tweet.text
  params = {
    token: SLACK_TOKEN,
    channel: channel_id,
    username: bot_name,
    text: post_text,
  }
  Slack.chat_postMessage params
end

def process(tweet)
  if will_post(tweet.text)
    post(tweet)
  end
end
