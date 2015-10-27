require 'Date'
require 'rss'
require 'open-uri'

# This class imports data from the SBS RSS Feed
# and stores them in Article db with a relation
# to a row in Source db which has name "SBS"
class SbsImporter
  def interpret_author(description)
    # Author's name is stored as content of a div tag
    author = description.gsub(/<div.*?>|<\/div>/, '')
    author
  end

  def scrape
    url = 'http://www.sbs.com.au/news/rss/dateline'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        @source = Source.find_by_name("SBS")
        author = interpret_author(item.dc_creator)
        @article = @source.articles.create(author: author,
                                           title: CGI.unescapeHTML(item.title),
                                           summary: CGI.unescapeHTML(item.description.strip!),
                                           img: nil,
                                           link: item.link,
                                           pub_date: item.pubDate)
      end
    end
  end
end
