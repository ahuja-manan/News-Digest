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
    @sources = [EntaggerTags.new]
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
        tags.each {|t| a.tag_list.add(t.downcase!)}
        a.save
      end
  	end
  end

end
