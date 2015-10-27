require 'Date'
require 'rss'
require 'open-uri'
# Converts html entities to text
include ActionView::Helpers::SanitizeHelper

# This class imports data from The Herald Sun RSS Feed
# and stores them in Article db with a relation
# to a row in Source db which has name "The Herald Importer"
class HeraldImporter
  def interpret_image(source)
    # regular expression for images
    # all image srcs at this source start with http and end with jpg
    image_regex = /http.*(jpg)/
    # get img src out of description string
    source.to_s[image_regex]
  end

  def interpret_summary(description)
    description.slice!('<![CDATA[')
    description.slice!(']]>')
    description
  end

  def scrape
    url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_sport_2789.xml'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        @source = Source.find_by_name('The Herald Sun)
        @article = @source.articles.create(author: nil, title: item.title,\
                                           summary: strip_tags(CGI.unescapeHTML(item.description)),\
                                           img: interpret_image(item.enclosure),\
                                           link: item.link, pub_date: item.pubDate)
      end
    end
  end
end
