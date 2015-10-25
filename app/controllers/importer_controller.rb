#
# This controller imports and scrapes data from 6 different 
# sources. It then puts all this interpreted & validated data i
# into an array for rendering to the index view.
#

class ImporterController < ApplicationController
before_action :authenticate_user

  def index
  	@age_articles = AgeArticle.all
  	@smh_articles = SmhArticle.all
  	@guardian_articles = GuardianArticle.all
  	@sbs_articles = SbsArticle.all
  	@herald_articles = HeraldArticle.all
  	@abc_articles = AbcArticle.all
    @ny_articles = NyArticle.all
    @article_sources =  [[@age_articles, AgeArticle::SOURCE], [@smh_articles, SmhArticle::SOURCE],
                       [@guardian_articles, GuardianArticle::SOURCE], [@sbs_articles, SbsArticle::SOURCE],
                       [@herald_articles, HeraldArticle::SOURCE], [@abc_articles, AbcArticle::SOURCE], [@ny_articles, NyArticle::SOURCE]]


   # @articles = [AgeArticle, SmhArticle, GuardianArticle, SbsArticle, HeraldArticle, AbcArticle, NyArticle]
   # @all_articles = []
   # @articles.each do |source|
   #   @all_articles.concat(source.all)
   # end
   # @all_articles.sort!(&:pub_date)

  end

  def my_interests
    @age_articles = AgeArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @smh_articles = SmhArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @guardian_articles = GuardianArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @sbs_articles = SbsArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @herald_articles = HeraldArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @abc_articles = AbcArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @ny_articles = NyArticle.tagged_with(current_user.interest_list, :any => true).to_a
    @article_sources =  [[@age_articles, AgeArticle::SOURCE], [@smh_articles, SmhArticle::SOURCE],
                        [@guardian_articles, GuardianArticle::SOURCE], [@sbs_articles, SbsArticle::SOURCE],
                        [@herald_articles, HeraldArticle::SOURCE], [@abc_articles, AbcArticle::SOURCE], [@ny_articles, NyArticle::SOURCE]]
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
