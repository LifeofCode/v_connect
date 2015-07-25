class Favourite < ActiveRecord::Base

	belongs_to :student
	belongs_to :organization

  validates :student, :organization, presence: true
  validates :student, uniqueness: { scope: :organization, message: "You've already favoured the organization, you can see it on your profile :)" }

end