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

class GuardianImporter

	include TagHelper
	
	# Scrape method that saves canned article data
	def scrape		
		# Define the HTTP object
	  uri = URI.parse("http://content.guardianapis.com")
		http = Net::HTTP.new(uri.host, uri.port)

		# Define the request_url 
		# (Guardian JSON API with the search term "startup")
		request_url = '/search?q=startup&api-key=b8wsksnttw4ehb3yhkq5zhug'

		# Make a GET request to the given url
		response = http.send_request('GET', request_url)

		# Parse the response body
		response_json = JSON.parse(response.body)	

		# The response JSON is structured such that the items 
		# are actually stored at response_json['response']['results']
		response_json['response']['results'].each do |item|
		    # Save article only if it doesn't already exist			
			#if GuardianArticle.find_by title: item["webTitle"]
		    #	return
		   # else
			    # Create GuardianArticle object for each item (with only the necessary attributes)	
			    @source = Source.find_by_name("The Guardian")	    				
				@article = @source.articles.create(author: nil, title: item["webTitle"], summary: nil, img: nil, link: item["webUrl"], pub_date: item["webPublicationDate"])
			    # Add tags
			    #article.tag_list.add("The Guardian", "startup", item["sectionName"])
			    #tag_text(item["webTitle"]).each {|k,v| article.tag_list.add(k)}		
			    # Save to model	    				
				#article.save
			#end
		end
	end	

end	