class SmhArticle < ActiveRecord::Base
  SOURCE = "Sydney Morning Herald"
    # Articles can have tags
  acts_as_taggable
end
