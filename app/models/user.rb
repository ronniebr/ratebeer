class User < ActiveRecord::Base
	include RatingAverage

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships
  has_many :beer_clubs, through: :memberships
	has_secure_password

	validates :username, uniqueness: true,
						 length: { in: 3..15 }
	validates :password, length: {minimum: 4},
						 format: {with: /[a-zA-Z]/, message: "Must contain at least one letter"}
												 
 def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer 
  end
end
