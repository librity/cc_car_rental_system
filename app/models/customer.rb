# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify
  
  before_save { email.downcase! }

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true, length: { maximum: 255 }
  validates :cpf, presence: true, uniqueness: true, cpf: true, length: { is: 11 },
                  numericality: { only_integer: true }

  def formatted_cpf
    "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
  end
end
