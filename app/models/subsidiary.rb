# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :cnpj, presence: true, length: { is: 14 }, uniqueness: true,
                   cnpj: true
end
