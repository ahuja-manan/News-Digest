require 'rubygems'
require 'bundler/setup'
require 'sentimental'
class SentimentalTags

	def tag text
		Sentimental.load_defaults
		Sentimental.threshold = 0.1
		s = Sentimental.new
		sentiment = s.get_sentiment text
		return sentiment.to_s
	end

end



