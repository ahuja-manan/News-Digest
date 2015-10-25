class AbcArticle < ActiveRecord::Base
  SOURCE = "ABC"
  # Articles can have tags
  acts_as_taggable

  # def self.search(search)
  # # Title is for the above case, the OP incorrectly had 'name'
  # if search
  #   find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  # else
  #   find(:all)
  # end
  # for article in @articles_source
  #   weighting = 0
  #   if article.tags #insert regex
  #     weighting += 4
  #   end
  #   if article.title
  #     weighting += 3
  #   end
  #   if article.description
  #     weighting += 2
  #   end
  #   if article.source
  #     weighting += 1
  #   end
  #   store each article in dictionary (article is attribute and value is weighting)
  # end
  #
  # sort articles by weight and if same weight, by date. <- do either here or in controller

  # How to put weight in here and search based on weight

  where("title LIKE ?", "%#{search}%")
  # ONE OF ARTICLE TAGS, ONE OF WORDS IN ARTICLE TITLE, ONE OF WORDS IN ARTICLE DESCRIPTION, SUBSTRING OF ARTICLE SOURCE
  # Article must match all keywords in search

  # Weightings:
  # - In Article Tags = 4
  # - In words in article title = 3
  # - In words of article description = 2
  # - In article source = 1

  # Sum weights together
  # Articles must be returned in order of descending weights. If same weight, do by date and time
  end
end
