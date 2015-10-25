require 'rubygems'
require 'bundler/setup'
require 'open_calais'

class CalasisTags

	API_KEY = '9B1LXxx5xhZ60FSbG9KRtKGwPMopkC8o'

	def tag text
		oc = OpenCalais::Client.new(api_key: API_KEY)
		oc_response = oc.enrich text
		topics = oc_response.topics
		topics_tags = []
		topics.each do |t|
        	topics_split = t[:name].split("&")
        	topics_tags += topics_split
      	end
      	return topics_tags
	end
end