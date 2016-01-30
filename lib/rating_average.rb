module RatingAverage
	extend ActiveSupport::Concern
 	def average_rating
		sum=0
		ratings.each do |rating|
			sum = sum + rating.score
		end
		avg = sum/ratings.count
		return avg	
 	end
end