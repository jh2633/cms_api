class Job < ApplicationRecord
  has_one :category
  has_and_belongs_to_many :keywords
end
