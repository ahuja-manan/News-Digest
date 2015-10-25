#
# This class imports data from The Herald Sun RSS Feed 
# It interprets and scrapes all the data to create 
# new HeraldArticle objects for all items which are then 
# saved to the HeraldArticle model.
#
# Author::  Manan Ahuja (655959)
#

require 'Date'
require 'rss'
require 'open-uri'


class HeraldImporter

	include TagHelper

	def interpret_image source
		# regular expression for images
		# all image srcs at this source start with http and end with jpg
		image_regex = /http.*(jpg)/
		
		# get img src out of description string
		source.to_s[image_regex] 
	end	

	# This method interprets the description to return the summary minus everything else
	def interpret_summary description
	    description.slice!('<![CDATA[')
		description.slice!(']]>')
		description
	end	

	# Scrape method that saves canned article data
	def scrape
		url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_sport_2789.xml'
		open(url) do |rss|
		    feed = RSS::Parser.parse(rss)
		    feed.items.each do |item|
		    	# Save article only if it doesn't already exist		    
		    	#if HeraldArticle.find_by title: item.title
		    	#	return
		    	#else
			    	# Create Article object for each item (with only the necessary attributes)
			    	@source = Source.find_by_name("The Herald Sun")	
			    	@article = @source.articles.create(author: nil, title: item.title, summary: item.description, 
			    						        img: interpret_image(item.enclosure), link: item.link, pub_date: item.pubDate)
			    	# Add tags
			    	#article.tag_list.add("The Herald Sun", "Sport")
			    	#tag_text(item.description).each {|k,v| article.tag_list.add(k)}	
			    	# Save to model
			    	#article.save
			    #end
		    end
		end
	end

end	