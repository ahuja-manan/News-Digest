# Generates popular tags for every article using Indico's API

require 'rubygems'
require 'bundler/setup'
require 'indico'

class IndicoTags

  API_KEY = '3cb6b1a3d8fadabd1b2f953348002044'

  def tag text
    Indico.api_key = API_KEY
	popular_tags = Indico.text_tags text
	popular_tags_sorted = popular_tags.sort_by { |_k, v| -1.0 * v }.first(10).to_h
	popular_tags = []
    popular_tags_sorted.each do |k,v|
      popular_split = k.split('_')
      popular_split.delete("and")
      popular_tags += popular_split
    end
    
    return popular_tags
  end
end