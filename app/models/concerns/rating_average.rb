module RatingAverage
 	def average_rating
		return 0 if ratings.empty?
    	ratings.map{ |r| r.score }.sum / ratings.count.to_f
 	end
end