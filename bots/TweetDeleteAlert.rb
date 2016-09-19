require 'twitter'
require './models.rb'

puts "ついけし監視 -> #{$deleted_streaming}"

Tweet.config.user do |tweet|
  if tweet.class == Twitter::Streaming::DeletedTweet
    data = Hashie::Mash.new(JSON.parse(Curl.get("#{$host}/Lavender/find_tweet/#{tweet.id}").body_str))
    if "#{tweet.id}" == data.tweet_id
      puts $deleted_streaming 
      data.full_text = "Delete\n" + "#{data.full_text}"
      Tweet.slack_post_options(data)
    else 
      # Slappy.say "誰かがつい消ししたっぽい"
    end
  end
end