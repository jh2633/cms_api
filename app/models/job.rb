class Job < ApplicationRecord
  belongs_to :category, optional: true
  has_many :jobs_and_keywords
  has_many :keywords, through: :jobs_and_keywords
end
