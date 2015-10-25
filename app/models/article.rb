class Article < ActiveRecord::Base

	validates_uniqueness_of :title
	acts_as_taggable
	belongs_to :source

	def self.search(search, articles)

		#Item = Struct.new(:article, :date, :weighting)


		searched_articles = Array.new
		weights = Hash.new
		for article in articles
			weighting = 0
			regex = /\b#{search}\b/

			if article.title != nil
				title_matches = article.title.scan regex
				if title_matches.length > 0
					weighting += 3
				end
			end
			if article.summary != nil
				summary_matches = article.summary.scan regex
				if summary_matches.length > 0
					weighting += 2
				end
			end

			regex = /#{search}/
			if article.source.name != nil
				source_match = article.source.name.scan regex
				if source_match.length > 0
					weighting += 1
				end
			end

			if weighting > 0
				weights[article] = weighting
				#searched_articles.push(article)
			end


			# TODO: ATTACH WEIGHTING TO EACH ARTICLE, IE VIA DICTIONARY. THEN SORT DICTIONARY AND RATE ACCORDINGLY. ALSO SORT BY DATE OTHERWISE THEN RETURN ARTICLE


		end
		#sorted_weights = weights.sort_by {|x| [x.game_date, x.team] }
		#weights.sort_by {|_key, value| value}

		weights.sort_by {|_key, value| [value, _key.pub_date]}

		#searched_articles = weights.keys
		searched_articles = weights.keys
	end
end
