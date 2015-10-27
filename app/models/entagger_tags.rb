require 'rubygems'
require 'engtagger'
# Generates noun tags for all articles using Entagger gem
class EntaggerTags
  def tag(text)
    # Create a parser object
    tagger = EngTagger.new

    # Add part-of-speech tags to text
    tagged = tagger.add_tags(text)

    # Return empty hash for articles with no summary
    return {} if tagged.nil?

    # Get all nouns (not enough proper nouns in the data to get appropriate tags)
    nouns = tagger.get_nouns(tagged)
    nouns.keys
  end
end
