class Article < ActiveRecord::Base
	
	validates_uniqueness_of :title
	acts_as_taggable
	belongs_to :source
end
