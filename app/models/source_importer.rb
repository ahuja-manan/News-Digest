# Stores all the Source's names in the Source db,
# before Articles are scraped
class SourceImporter
  def scrape
    sources = ["The Age", "ABC", "The Herald Sun",
               "Sydney Morning Herald", "SBS",
               "The Guardian", "New York Times"]
    sources.each do |s|
      each_source = Source.new(name: s)
      each_source.save
    end
  end
end
