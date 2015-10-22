#
# This class imports data from The Age RSS Feed 
# It interprets and scrapes all the data to create 
# new AgeArticle objects for all items which are then 
# saved to the AgeArticle model.
#
# Author::  Manan Ahuja (655959)
#

require 'Date'
require 'rss'
require 'open-uri'


class AgeImporter

	include TagHelper
	
	# This method interprets the description to return the image url
	def interpret_image description
		# regular expression for images
		# all image srcs at this source start with http and end with jpg
		image_regex = /http.*(jpg)/
		# get img src out of description string
		description.to_s[image_regex] 
	end	

	# This method interprets the description to return the summary minus everything else
	def interpret_summary description

		# regular expression for summary
		# all descriptions at this source start after the closing </p> tag
		summary_regex = /<\/p>.*/

		# get summary out of bigger description string
		summary = description.to_s[summary_regex]

		# get rid of </p> tag from the beginning of summary string 
		summary.slice!('</p>')

		# replace double quotes within summary strings with escaped double quotes
		# a few items at this source have double quotes within descriptions
		# it is important to escape them to export valid json, xml and csv
		summary = summary.gsub(/(")/,'\\"')

		summary
	end	


	# Scrape method that saves canned article data
	def scrape
		url = 'http://www.theage.com.au/rssheadlines/technology-news/article/rss.xml'
		open(url) do |rss|
		    feed = RSS::Parser.parse(rss)
		    feed.items.each do |item|
		    	# Save article only if it doesn't already exist		    	
		    	if AgeArticle.find_by title: item.title
		    		return
		    	else			    	
			    	# Create Article object for each item (with only the necessary attributes)
			    	article = AgeArticle.new(author: nil, title: item.title, summary: interpret_summary(item.description), 
			    						        img: interpret_image(item.description), link: item.link, pub_date: item.pubDate)
			    	# Add tags
			    	article.tag_list.add("The Age", "Technology")
			    	tag_text(interpret_summary(item.description)).each {|k,v| article.tag_list.add(k)}		    	
			    	# Save to model		
			    	article.save
			    end
		    end
		end
	end

end	