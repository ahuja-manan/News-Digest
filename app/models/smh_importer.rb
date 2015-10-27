#
# This class imports data from the Sydney Morning Herald RSS Feed 
# and stores them in Article db with a relation
# to a row in Source db which has name "Syndey Morning Herald"

require 'Date'
require 'rss'
require 'open-uri'


class SmhImporter

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
    # Only some items at this source have img tags and hence the if condition
	if interpret_image(description)
	  # regular expression for summary
	  # all descriptions at this source start after the closing </p> tag
	  summary_regex = /<\/p>.*/

	  # get summary out of bigger description string
	  summary = description.to_s[summary_regex]

	  # get rid of </p> tag from the beginning of summary string 
	  summary.slice!('</p>')
	  CGI.unescapeHTML(summary)

	else
	  description
	end

  end	


  def scrape
	url = 'http://www.smh.com.au/rssheadlines/soccer/article/rss.xml'
	open(url) do |rss|
      feed = RSS::Parser.parse(rss)
	  feed.items.each do |item|
		# Create Article object for each item (with only the necessary attributes)	
		@source = Source.find_by_name("Sydney Morning Herald")		    	
		@article = @source.articles.create(author: nil,
										   title: item.title, 
										   summary: interpret_summary(item.description), 
			    						   img: interpret_image(item.description),
			    						   link: item.link, pub_date: item.pubDate)
		
	  end
	end
  end

end	