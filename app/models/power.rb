class Power < ApplicationRecord
  has_and_belongs_to_many :heroes
end
