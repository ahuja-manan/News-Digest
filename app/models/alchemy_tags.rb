require 'rubygems'
require 'bundler/setup'
require 'alchemy_api'

class AlchemyTags

	API_KEY = '762220b2942bf268b8d044fad1a5464f9a4bdacf'

	def tag text
		AlchemyAPI.key = API_KEY
		concepts = AlchemyAPI::EntityExtraction.new.search(text: text)
		concepts_tags = []
		concepts.each { |c| concepts_tags.push(c['text'], c['type'] )}
		concepts_tags

    end


end