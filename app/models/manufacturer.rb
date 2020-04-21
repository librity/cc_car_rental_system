# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
