require 'rubygems'
require 'bundler/setup'
require 'open_calais'
# Generates topic tags for articles using Open Calasis's API
# Has a limit on the number of articles per API Key
# Limit is exceeded very quickly, hence not included in Admin Controller
class CalasisTags
  API_KEY = 'kXSoViH2goLC4AuZ0iys0NLfLbPYuZ4s'

  def tag(text)
    oc = OpenCalais::Client.new(api_key: API_KEY)
    topics_tags = []
    oc_response = oc.enrich text
    topics = oc_response.topics
    return unless topics?nil
    topics.each do |t|
      topics_split = t[:name].split('&')
      topics_tags += topics_split
    end
    topics_tags
  end
end
