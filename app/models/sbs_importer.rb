#
# This class imports data from the SBS RSS Feed 
# It interprets and scrapes all the data to create 
# new SbsArticle objects for all items which are then 
# saved to the SbsArticle model.
#
# Author::  Manan Ahuja (655959)
#

require 'Date'
require 'rss'
require 'open-uri'

class SbsImporter

	include TagHelper

	# Scrape method that saves canned article data
	def scrape
		url = 'http://www.sbs.com.au/news/rss/dateline'
		open(url) do |rss|
		    feed = RSS::Parser.parse(rss)
		    feed.items.each do |item|
		    	# Save article only if it doesn't already exist		    	
		    	if SbsArticle.find_by title: item.title
		    		return
		    	else
			    	# Create Article object for each item (with only the necessary attributes)
			    	article = SbsArticle.new(author: item.dc_creator, title: item.title, summary: item.description, 
			    						        img: nil, link: item.link, pub_date: item.pubDate)
			    	# Add tags
			    	article.tag_list.add("SBS")
			    	tag_text(item.description).each {|k,v| article.tag_list.add(k)}	
			    	# Save to model		    	
			    	article.save
			    end
		    end
		end
	end

end	