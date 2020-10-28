# frozen_string_literal: true

class Hero < ApplicationRecord
  validates :name, presence: true
  validates :height, :weight, numericality: { only_integer: true }
  belongs_to :publisher, optional: true
  belongs_to :race, optional: true
  has_and_belongs_to_many :powers
end
