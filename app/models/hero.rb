class Hero < ApplicationRecord
  belongs_to :publisher, optional: true
  belongs_to :race, optional: true
  has_and_belongs_to_many :powers
end
