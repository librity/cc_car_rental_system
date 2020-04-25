# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :cnpj, presence: true, uniqueness: true, cnpj: true,
                   length: { is: 14 }, numericality: { only_integer: true }
  validates :address, presence: true

  def formatted_cnpj
    "#{cnpj[0..1]}.#{cnpj[2..4]}.#{cnpj[5..7]}/#{cnpj[8..11]}-#{cnpj[12..13]}"
  end
end
