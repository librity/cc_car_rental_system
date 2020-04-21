# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :cnpj, presence: true, uniqueness: true, cnpj: true,
                   length: { is: 14 }, numericality: { only_integer: true }
  validates :address, presence: true
end
