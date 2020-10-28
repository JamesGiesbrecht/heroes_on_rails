# frozen_string_literal: true

class Publisher < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :heros, dependent: :nullify
end
