class Article < ActiveRecord::Base

	validates_uniqueness_of :title
	acts_as_taggable
	belongs_to :source

	# This method searches through the articles, given an input,
	# in order of weight, then publication date
	def self.search(search, articles)

		# Initialise array of searched articles and hash table of weights
		searched_articles = {}
		weights = {}

		

		for article in articles

			weighting = 0
			# change this, convert string to instance var
			weight_map = { article.tag_list => 4, article.title => 3, article.summary => 2, article.source.name => 1 }
			# Search just for the words in the input
			regex = /#{search}/i

			weight_map.each do |k,w|
				attribute = k
				if attribute != nil
					if attribute.is_a?(Array)
						attribute.each do |e|
							if e.scan(regex).length > 0
								weighting += w
								break
							end
						end
					elsif attribute.is_a?(String)
						if attribute.scan(regex).length > 0
							weighting += w
						end
					end

				end
			end
			
			if weighting > 0
				weights[article] = weighting
			end
		end

		# Sort by weight, then by date on matching weights
		weights = weights.sort_by {|k, v| [v, k.pub_date]}.reverse.to_h
		#weights.each {|k,v| puts "#{v} #{k}"}

		# Return the articles themselves
		searched_articles = weights.keys
	end
end
