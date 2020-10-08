class Hero < ApplicationRecord
  belongs_to :publisher
  belongs_to :race
end
