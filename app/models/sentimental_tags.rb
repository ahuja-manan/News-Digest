require 'rubygems'
require 'bundler/setup'
require 'sentimental'

# This class generates tags for articles using Sentiment API
# returns one of three strings - positive, neutral and negative
class SentimentalTags
  def tag(text)
    Sentimental.load_defaults
    Sentimental.threshold = 0.1
    s = Sentimental.new
    sentiment = s.get_sentiment text
    sentiment.to_s
  end
end
