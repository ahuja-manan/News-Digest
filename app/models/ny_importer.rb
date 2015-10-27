require 'Date'
require 'open-uri'
require 'json'
require 'net/http'
# This class imports data from New York times JSON API
# and stores them in Article db with a relation
# to a row in Source db which has name "New York Times"
class NyImporter
  def scrape
    # Define the HTTP object
    uri = URI.parse('http://api.nytimes.com')
    http = Net::HTTP.new(uri.host, uri.port)
    # Define the request_url
    request_url = '/svc/topstories/v1/travel.json?api-key=9ec258f30fce8fddb39b36211d1ffbc2:4:72740446'

    # Make a GET request to the given url
    response = http.send_request('GET', request_url)

    # Parse the response body
    response_json = JSON.parse(response.body)
    response_json['results'].each do |item|
      @source = Source.find_by_name('New York Times')
      @article = @source.articles.create(title: item['title'],\
                                         pub_date: item['published_date'],\
                                         summary: item['abstract'],\
                                         author: item['byline'], img: nil,\
                                         link: item['url'])
    end
  end
end
