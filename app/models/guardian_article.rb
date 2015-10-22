class GuardianArticle < ActiveRecord::Base
  SOURCE = "The Guardian"
    # Articles can have tags
  acts_as_taggable
end
