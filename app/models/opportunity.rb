class Opportunity < ActiveRecord::Base

	belongs_to :organization
  validates :title, presence: true
  validates :content, presence: true

end