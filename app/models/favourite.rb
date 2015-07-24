class Favourite < ActiveRecord::Base

	belongs_to :student
	belongs_to :organization

  validates :student, :organization, presence: true

end