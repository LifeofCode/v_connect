class Student < ActiveRecord::Base
	
	has_many :favourites
	has_many :organizations, through: :favourites

  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, format: {with: /\w+\.?\w+@\w+\.\w+/, message: "ID invalid"}, uniqueness: true

end