#
# This module uses the EngTagger gem to 
# fetch nouns out of text.  
#
require 'rubygems'
require 'engtagger'

module TagHelper

	def tag_text text 
		# Create a parser object
		tgr = EngTagger.new

		# Add part-of-speech tags to text
		tagged = tgr.add_tags(text)

		# Return empty hash for articles with no summary
		if tagged == nil
			return {}
		end

		# Get all nouns (not enough proper nouns in the data to get appropriate tags)
		tag_list = tgr.get_nouns(tagged)
	end	

end	