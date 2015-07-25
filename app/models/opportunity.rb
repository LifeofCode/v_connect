class Opportunity < ActiveRecord::Base

	belongs_to :organization
  validates :title, :content, presence: true

end