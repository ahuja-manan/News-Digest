# This controller helps admin in Scraping, tagging all Articles
# Admin can email all Subscribers ten new interested articles
class AdminController < ApplicationController
  # GET /admin
  def index
  end

  # GET /admin/scrape
  def scrape
    # stores all Source strings in Source table
    # Source is scraped before Article, since Source
    # has one to many relationship with Article
    SourceImporter.new.scrape
    importers = [AgeImporter.new, SmhImporter.new, GuardianImporter.new,
                 SbsImporter.new, HeraldImporter.new,
                 AbcImporter.new, NyImporter.new]

    # scrapes all sources and stores all articles in Article db
    importers.each(&:scrape)
  end

  # GET /admin/tag
  def tag
    @articles = Article.all
    @articles.each do |a|
      if !a.summary.nil?
        text = a.summary + a.title
        text.tr!('.', ' ')
      else
        text = a.title
      end
      tags_save unless text.nil?
    end
  end

  private

  def tags_save
    # tags articles with four different ways*
    @sources = [EntaggerTags.new, IndicoTags.new,
                SentimentalTags.new, AlchemyTags.new]
    @sources.each do |s|
      tags = s.tag(text)
      # SentimentalTags returns String, all others return Array
      if tags.is_a? Array
        tags.each { |t| a.tag_list.add(t) }
        a.save
      elsif tags.is_a? String
        a.tag_list.add(tags)
        a.save
      end
    end
  end

  # GET /admin/mail
  def mail
    # Emails news digest to all Subscribers
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
    # subscriber = User who wants to recieve emails
    @subscribers = User.where(is_registered: '1')

    # Build the content for individual subscribers
    @subscribers.each do |subscriber|
      @subscriber = subscriber
      # limit mailed articles to 10
      @articles = get_content(@subscriber).take(10)
      # Message params
      message = {
        subject: 'Your news digest',
        from_name: 'The Digest',
        from_email: 'no-reply@thedigest.com',
        to: [{ email: @subscriber.email }],
        html: render_to_string('digest_mailer/mail.html.erb', layout: false)
      }
      @mandrill_client.messages.send message
      # Add sent articles to articles_mailed of the subscriber
      articles_mailed(@subscriber, @articles)
    end
  end

  private

  def get_content(subscriber)
    # subscriber's interests
    all_relevant_articles = Article.tagged_with(subscriber.interest_list, :any => true).to_a
    # stop mailing articles that have already been mailed
    articles_already_mailed_ids = subscriber.mailed_articles
    articles = []
    all_relevant_articles.each do |relevant_article|
      articles.push(relevant_article) unless\
      articles_already_mailed_ids.include?(relevant_article.id)
    end
    articles
  end

  private

  def articles_mailed(subscriber, articles)
    articles.each do |a|
      subscriber.mailed_articles.push(a.id)
    end
    subscriber.save!
  end
end
