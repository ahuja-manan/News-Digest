require 'Date'
require 'rss'
require 'open-uri'
# This class imports data from ABC's RSS Feed
# and stores them in Article db with a relation
# to a row in Source db which has name "ABC"
class AbcImporter
  def scrape
    url = 'http://www.abc.net.au/radionational/feed/3727018/rss.xml'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        @source = Source.find_by_name('ABC')
        @article = @source.articles.create(author: item.dc_creator,
                                           title: item.title,
                                           summary: item.description,
                                           img: nil, link: item.link,
                                           pub_date: item.pubDate)
      end
    end
  end
end
