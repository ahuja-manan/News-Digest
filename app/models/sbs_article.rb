class SbsArticle < ActiveRecord::Base
	SOURCE = "SBS"
	  # Articles can have tags
  acts_as_taggable
end
