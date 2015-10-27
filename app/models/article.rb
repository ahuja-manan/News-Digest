# Stores articles from all importers
class Article < ActiveRecord::Base
  # prevents duplicates on the basis of title
  validates_uniqueness_of :title

  # articles have a tag_list attribute
  acts_as_taggable

  # many articles belong to one source
  belongs_to :source

  # This method searches through the articles, given an input,
  # in order of weight, then publication date
  def self.search(search, articles)
    # divide search string into keywords
    # keywords need to have space between them
    keywords = search.split(' ')
    all_matched_articles = []

    # for each keyword find a hash of matched articles
    keywords.each do |k|
      weights = {}
      articles.each do |article|
        weighting = 0
        weight_map = { article.tag_list => 4, article.title => 3, article.summary => 2, article.source.name => 1 }
        # searching is case insenstive
        regex = /#{k}/i
        weight_map.each do |m, w|
          attribute = m
          if attribute != nil
            # to match article's tag_list
            if attribute.is_a?(Array)
              attribute.each do |e|
                if e.scan(regex).length > 0
                  weighting += w
                  break
                end
              end
            # to match article's name, summary and name
            elsif attribute.is_a?(String)
              if attribute.scan(regex).length > 0
                weighting += w
                break
              end
            end
          end
        end
        # gets a hash of matched articles
        if weighting > 0
          weights[article] = weighting
        end
      end
      # array of matched articles for each keyword
      all_matched_articles.push(weights)
    end

    # all_matched_arrays - array of hashes
    # each hash for keyword
    search_result = all_matched_articles[0].keys
    all_matched_articles.each do |matched|
      search_result &= matched.keys
    end
    # search_result -
    # array of articles that matches all keywords

    # remove_articles -
    # array of articles that don't match all keywords
    remove_articles = articles.to_a - search_result
    # delete unmatched articles from every hash
    all_matched_articles.each do |matched|
      remove_articles.each do |r|
        matched.delete(r)
      end
    end

    # sum weights for each article from every hash
    # retuns an array of hashes
    # each hash has one article as key, and
    # value as the sum of weights
    all_matched_articles = all_matched_articles.flat_map(&:to_a)\
                           .group_by(&:first)\
                           .map { |k, a| { k => (a.reduce(0) { |tot, (_, v)| tot + v} ) } }
    # convert from an array of hashes to one hash
    all_matched_articles = all_matched_articles.inject(&:merge)
    # sort by weights and publication date
    all_matched_articles = all_matched_articles.sort_by { |k, v| [v, k.pub_date] }.reverse.to_h
    # return articles that match search
    all_matched_articles.keys
  end
end
