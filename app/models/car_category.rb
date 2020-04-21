# frozen_string_literal: true

class CarCategory < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :daily_rate, presence: true, numericality: true
  validates :insurance, presence: true, numericality: true
  validates :third_party_insurance, presence: true, numericality: true
end
