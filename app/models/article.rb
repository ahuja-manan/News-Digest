class Article < ActiveRecord::Base

	validates_uniqueness_of :title
	acts_as_taggable
	belongs_to :source

	def self.search(search)
		# if search
		# 	find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		#
		# else
  	# 	find(:all)
		# end
		where("title LIKE ?", "%#{search}%")


	end
end
