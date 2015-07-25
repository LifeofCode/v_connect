class Favourite < ActiveRecord::Base

	belongs_to :student
	belongs_to :organization

  validates :student, :organization, presence: true
  validates :student_id, uniqueness: { scope: :organization_id, message: "You've already favoured this organization, you can see it on your profile :)" }
# TODO: leverage this validation when displaying errors

end