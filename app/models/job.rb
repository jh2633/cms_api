class Job < ApplicationRecord
  belongs_to :category, optional: true
  has_and_belongs_to_many :keywords, optional: true
end
