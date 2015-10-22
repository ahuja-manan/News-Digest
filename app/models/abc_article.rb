class AbcArticle < ActiveRecord::Base
  SOURCE = "ABC"
  # Articles can have tags
  acts_as_taggable
end
