class Source < ActiveRecord::Base
	validates_uniqueness_of :name

	# One source is related to 1..n articles
	has_many :articles
end
