class User < ActiveRecord::Base
	include RatingAverage

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_secure_password

	validates :username, uniqueness: true,
						 length: { in: 3..15 }
	validates :password, length: {minimum: 4},
						 format: {with: /[a-zA-Z]/, message: "Must contain at least one letter"}
												 
end
