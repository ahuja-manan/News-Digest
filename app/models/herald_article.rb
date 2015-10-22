class HeraldArticle < ActiveRecord::Base
	SOURCE = "The Herald Sun"
	  # Articles can have tags
  acts_as_taggable
end
