class Keyword < ApplicationRecord
  has_many :jobs_and_keywords
  has_many :jobs, through: :jobs_and_keywords
end
