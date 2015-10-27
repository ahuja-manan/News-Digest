# This class imports data from The Age's RSS Feed
# and stores them in Article db with a relation
# to a row in Source db which has name "The Age"
require 'Date'
require 'rss'
require 'open-uri'

class AgeImporter
  # This method interprets the description to return the image url
  def interpret_image(description)
    # regular expression for images
    # all image srcs at this source start with http and end with jpg
    image_regex = /http.*(jpg)/
    # get img src out of description string
	description.to_s[image_regex]
  end

  def interpret_summary(description)
    # regular expression for summary
    # all descriptions at this source start after the closing </p> tag
    summary_regex = /<\/p>.*/

    # get summary out of bigger description string
    summary = description.to_s[summary_regex]

    # get rid of </p> tag from the beginning of summary string
    summary.slice!('</p>')
    summary
  end

  def scrape
    url = 'http://www.theage.com.au/rssheadlines/technology-news/article/rss.xml'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        @source = Source.find_by_name('The Age')
        @article = @source.articles.create(author: nil,\
                                           title: item.title,\
                                           summary: interpret_summary(item.description),\
                                           img: interpret_image(item.description),\
                                           link: item.link, pub_date: item.pubDate)
      end
    end
  end
end

