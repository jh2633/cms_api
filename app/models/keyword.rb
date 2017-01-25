class Keyword < ApplicationRecord
  has_many :jobs_and_keywords
  has_and_belongs_to_many :jobs
end
