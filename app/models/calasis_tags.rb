require 'rubygems'
require 'bundler/setup'
require 'open_calais'

class CalasisTags

	API_KEY = 'kXSoViH2goLC4AuZ0iys0NLfLbPYuZ4s'

	def tag text
		oc = OpenCalais::Client.new(api_key: API_KEY)
		if text != nil
			oc_response = oc.enrich text
			topics = oc_response.topics
			topics_tags = []
			if topics != nil
				topics.each do |t|
					
		        	topics_split = t[:name].split("&")
		        	topics_tags += topics_split
		      	end
		    end
	    else
	    	topics_tags = []
	    end
      	return topics_tags
	end
end