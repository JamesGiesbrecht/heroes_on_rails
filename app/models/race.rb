# frozen_string_literal: true

class Race < ApplicationRecord
  validates :race, presence: true, uniqueness: true
  has_many :heros, dependent: :nullify
end
