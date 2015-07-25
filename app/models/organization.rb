class Organization < ActiveRecord::Base
  
	has_many :favourites
  has_many :opportunities
	has_many :students, through: :favourites

  has_secure_password

  validates :name, presence: true
  validates :email, format: {with: /\w+\.?\w+@\w+\.\w+/, message: "invalid"}, uniqueness: true

end