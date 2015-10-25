#
# This controller imports and scrapes data from 6 different 
# sources. It then puts all this interpreted & validated data i
# into an array for rendering to the index view.
#

class ImporterController < ApplicationController
before_action :authenticate_user

  def index
  	@articles = Article.all
   # @articles = [AgeArticle, SmhArticle, GuardianArticle, SbsArticle, HeraldArticle, AbcArticle, NyArticle]
   # @all_articles = []
   # @articles.each do |source|
   #   @all_articles.concat(source.all)
   # end
    @articles.order! 'pub_date DESC'
  end

  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, :any => true).to_a
    render 'index'
  end

 # def scrape
 # 	importers = [AgeImporter.new, SmhImporter.new, GuardianImporter.new, SbsImporter.new, HeraldImporter.new, AbcImporter.new, NyImporter.new]
  #	importers.each do |importer|
  #		importer.scrape
  #	end	
  #end	

# Scrape and then render. The scrape methods of all the 
# importer classes take care of importing only the latest articles
  #def refresh
   # scrape
    #index
    #render 'index'
  #end


end
