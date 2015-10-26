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

			# Assign weighting for tag matching
			# if article.tag_list != nil
			# 	for tag in article.tag_list
			# 		tag_matches = tag.scan regex
			# 		if tag_matches.length > 0
			# 			weighting += 4
			# 			break;
			# 		end
			# 	end
			# end

			# # Assign weighting for title matching
			# if article.title != nil
			# 	title_matches = article.title.scan regex
			# 	if title_matches.length > 0
			# 		weighting += 3
			# 	end
			# end

			# # Assign weighting for summary matching
			# if article.summary != nil
			# 	summary_matches = article.summary.scan regex
			# 	if summary_matches.length > 0
			# 		weighting += 2
			# 	end
			# end

			# Search for substrings for the source name
			# regex = /#{search}/i
			# if article.source.name != nil
			# 	source_match = article.source.name.scan regex
			# 	if source_match.length > 0
			# 		weighting += 1
			# 	end
			# end

			# If there is a match from searching, add this to the returned
			# array of articles. But first store in hash table to sort by weight/date
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
