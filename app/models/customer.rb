# frozen_string_literal: true

class Customer < ApplicationRecord
  before_save { email.downcase! }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 255 }
  validates :cpf, presence: true, uniqueness: true, cpf: true, length: { is: 11 },
                  numericality: { only_integer: true }
end
