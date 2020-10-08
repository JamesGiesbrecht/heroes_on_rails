class Hero < ApplicationRecord
  belongs_to :publisher
  belongs_to :race
  has_and_belongs_to_many :powers
end
