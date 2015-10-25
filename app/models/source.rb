
class Source < ActiveRecord::Base
	validates_uniqueness_of :name
	has_many :articles
end
