require 'twitter'
require 'curb'
require 'hashie'
$host = ENV['HOST']
$user_streaming = true
$deleted_streaming = true

puts "TwitterController"

class Tweet
  class << self

    def config
      Twitter::Streaming::Client.new do |config|
        config.consumer_key    = ENV["MAIN_CONSUMER_KEY"]
        config.consumer_secret = ENV["MAIN_CONSUMER_SECRET"]
        config.access_token    = ENV["MAIN_ACCESS_TOKEN"]
        config.access_token_secret = ENV["MAIN_ACCESS_TOKEN_SECRET"]
      end
    end

    def onfig_rest
      Twitter::REST::Client.new do |config|
        config.consumer_key    = ENV["MAIN_CONSUMER_KEY"]
        config.consumer_secret = ENV["MAIN_CONSUMER_SECRET"]
        config.access_token    = ENV["MAIN_ACCESS_TOKEN"]
        config.access_token_secret = ENV["MAIN_ACCESS_TOKEN_SECRET"]
      end
    end

    def slack_post(attachments)
      conf = { channel: "#bot_tech", username: "Lavender", icon_url: "http://19.xmbs.jp/img_fget.php/_bopic_/923/e05cec.png"}.merge(attachments)
      Curl.post( ENV['WEBHOOKS'],JSON.pretty_generate(conf))
      puts JSON.pretty_generate(conf)
    end

    def slack_post_options(tweet)
      attachments = [{
        author_icon: tweet.user.profile_image_url.to_s,
        author_name: tweet.user.name,
        author_subname: "@#{tweet.user.screen_name}",
        text: tweet.full_text,
        author_link: tweet.uri.to_s,
        color: tweet.user.profile_link_color
      }] 
      if tweet.media
        tweet.media.each_with_index do |v,i|
          attachments[i] ||= {}
          attachments[i].merge!({image_url: v.media_uri })
        end
      end
      Tweet.slack_post({attachments: attachments})
    end

    def database_post(tweet)
      Curl.post(
        "#{$host}/stocking_tweet",
        ({ 
          tweet_id: tweet.id,
          name: tweet.user.screen_name,
          user_name: tweet.user.name,
          text: tweet.full_text,
          icon: tweet.user.profile_image_url,
          url:tweet.uri, 
          color: tweet.user.profile_link_color
        }).to_json)
    end

    def list_join_members(list_id)
      Tweet.config_rest.list_members(list_id, count: 1000).map{ |user| user.screen_name }
    end

    def tweet(text)
      Tweet.config_rest.update(text)
    end
  end
end

