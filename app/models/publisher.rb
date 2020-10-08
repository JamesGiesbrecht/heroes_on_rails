class Publisher < ApplicationRecord
  # If a publisher is destroyed, associated heroes are as well
  has_many :heroes, dependant: destroy
end
