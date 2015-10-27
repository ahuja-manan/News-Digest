# This class imports data from The Guardian JSON API
# and stores them in Article db with a relation
# to a row in Source db which has name "The Guardian"
require 'Date'
require 'open-uri'
require 'json'
require 'net/http'

class GuardianImporter
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
      @source = Source.find_by_name("The Guardian")    				
      @article = @source.articles.create(author: nil,\
                                         title: item["webTitle"],\
                                         summary: nil, img: nil,\
                                         link: item["webUrl"],\
                                         pub_date: item["webPublicationDate"])
    end
  end
end
