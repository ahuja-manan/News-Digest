#
# This class imports data from ABC's RSS Feed 
# It interprets and scrapes all the data to create 
# new AbcArticle objects for all items which are then 
# saved to the AbcArticle model.
#
# Author::  Manan Ahuja (655959)
#

require 'Date'
require 'rss'
require 'open-uri'


class AbcImporter

  include TagHelper

  # Scrape method that saves canned article data
  def scrape
    url = 'http://www.abc.net.au/radionational/feed/3727018/rss.xml'
	open(url) do |rss|
	  feed = RSS::Parser.parse(rss)
	  feed.items.each do |item|
	    # Save article only if it doesn't already exist
	    #if Article.find_by title: item.title
	     # return
	    #else	
	      @source = Source.find_by_name("ABC")
	      @article = @source.articles.create(author: item.dc_creator, title: item.title, summary: item.description,img: nil, link: item.link, pub_date: item.pubDate)
	      # Create Article object for each item (with only the necessary attributes)
		  #@article = Article.new(sourceID: 1, author: item.dc_creator, title: item.title, summary: item.description, 
			    						       # img: nil, link: item.link, pub_date: item.pubDate)
		 # source = Source.find_by_name("ABC");
		 # article.source = source
		  # Add tags
		  #article.tag_list.add("ABC", "Current Affairs")
	      #tag_text(item.description).each {|k,v| article.tag_list.add(k)}
	      # Save to model
		  #@article.save
	    #end
      end
    end
  end
end	