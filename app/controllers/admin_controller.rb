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
        tags.each {|t| a.tag_list.add(t)}
        a.save
      end
  	end
  end

  def mail
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
    @subscribers = User.where(is_registered: "1")

    #Build the content for individual subscribers
    @subscribers.each do |subscriber| 
      @subscriber = subscriber

      all_relevant_articles = Article.tagged_with(subscriber.interest_list, :any => true).to_a 
      articles_already_mailed_ids = subscriber.mailed_articles 
      @articles = []

      all_relevant_articles.each do |relevant_article|
        if !articles_already_mailed_ids.include?(relevant_article.id)
          @articles.push(relevant_article)
        end
      end
      

      @articles = @articles.take(10)
      #Message params
      message = { 
        :subject=> "Your news digest", 
        :from_name=> "The Digest",
        :from_email=>"no-reply@thedigest.com",
        :to=> [{email: @subscriber.email}],  
        :html=>render_to_string('digest_mailer/mail.html.erb', :layout => false), 
      } 
      @mandrill_client.messages.send message
      
      articles_mailed(@subscriber, @articles)
      # Add sent articles to @articles_mailed

    end 
  end

  def articles_mailed(subscriber, articles)
    articles.each do |a|
      subscriber.mailed_articles.push(a.id)
    end
    subscriber.save!
  end 

end
