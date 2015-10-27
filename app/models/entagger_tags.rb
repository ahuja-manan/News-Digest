require 'rubygems'
require 'engtagger'

class EntaggerTags

	def tag text
		# Create a parser object
		tagger = EngTagger.new

		# Add part-of-speech tags to text
		tagged = tagger.add_tags(text)

		# Return empty hash for articles with no summary
		if tagged == nil
			return {}
		end

		# Get all nouns (not enough proper nouns in the data to get appropriate tags)
		nouns = tagger.get_nouns(tagged)
		noun_tags = nouns.keys
	end	

end	