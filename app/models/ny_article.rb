class NyArticle < ActiveRecord::Base
	SOURCE = "New York Times"
	acts_as_taggable
end
