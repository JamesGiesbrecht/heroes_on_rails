class Publisher < ApplicationRecord
  # If a publisher is destroyed, associated heroes are as well
  has_many :heros, dependant: destroy
end
