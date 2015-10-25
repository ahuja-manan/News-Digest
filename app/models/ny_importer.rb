#
# This class imports data from The Guardian JSON API 
# It interprets and scrapes all the data to create 
# new GuardianArticle objects for all items which are then 
# saved to the GuardianArticle model.
#
# Author::  Manan Ahuja (655959)
#

require 'Date'
require 'open-uri'
require 'json'
require 'net/http'

class NyImporter

	include TagHelper
	
	# Scrape method that saves canned article data
	def scrape		
		# Define the HTTP object
	  uri = URI.parse("http://api.nytimes.com")
		http = Net::HTTP.new(uri.host, uri.port)

		# Define the request_url 
		# (Guardian JSON API with the search term "startup")
		request_url = '/svc/topstories/v1/travel.json?api-key=9ec258f30fce8fddb39b36211d1ffbc2:4:72740446'

		# Make a GET request to the given url
		response = http.send_request('GET', request_url)

		# Parse the response body
		response_json = JSON.parse(response.body)	

		# The response JSON is structured such that the items 
		# are actually stored at response_json['response']['results']
		response_json['results'].each do |item|
		    # Save article only if it doesn't already exist			
			#if NyArticle.find_by title: item["title"]
		    #	return
		    #else
			    # Create GuardianArticle object for each item (with only the necessary attributes)	
			    @source = Source.find_by_name("New York Times")		    				
				@article = @source.articles.create(title: item['title'],pub_date: item['published_date'],summary: item['abstract'], author: item['byline'], img: nil, link: item['url'])
			    # Add tags
			    #article.tag_list.add("New york times", "travel")
			    #tag_text(item["webTitle"]).each {|k,v| article.tag_list.add(k)}		
			    # Save to model	    				
				#article.save
			#end
		end
	end	

end	