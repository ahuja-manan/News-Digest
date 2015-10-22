class AgeArticle < ActiveRecord::Base
	SOURCE = "The Age"
	  # Articles can have tags
  acts_as_taggable
end
