require 'rubygems'
require 'engtagger'
# Generates noun tags using Entagger gem
class EntaggerTags
  def tag(text)
    # Create a parser object
    tagger = EngTagger.new

    # Add part-of-speech tags to text
    tagged = tagger.add_tags(text)

    # Return empty hash for articles with no summary
    return {} if tagged.nil?

    # Get all nouns
    nouns = tagger.get_nouns(tagged)
    nouns.keys
  end
end
