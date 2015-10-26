class AdminController < ApplicationController
  def index
  end

  def scrape
 SourceImporter.new.scrape
 	importers = [AgeImporter.new, SmhImporter.new, GuardianImporter.new, SbsImporter.new, HeraldImporter.new, AbcImporter.new, NyImporter.new]
  	importers.each do |importer|
  		importer.scrape
  	end
  end

  def tag
  	#if article table is empty
    @sources = [EntaggerTags.new,IndicoTags.new, SentimentalTags.new, AlchemyTags.new]
  	@articles = Article.all
  	@articles.each do |a|
  		if(a.summary != nil)
  			text = a.summary + a.title
  			text.gsub!('.',' ')
  		else
  			text = a.title
  		end

      @sources.each do |s|
        tags = s.tag(text)
        if tags.is_a? Array
          tags.each {|t| a.tag_list.add(t)}
          a.save
        elsif tags.is_a? String
          a.tag_list.add(tags)
          a.save
        end
          
      end
  	end
  end

end
