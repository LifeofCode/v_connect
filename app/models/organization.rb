class Organization < ActiveRecord::Base
  
  has_secure_password

	has_many :favourites
  has_many :posts
	has_many :students, through: :favourites

end