# frozen_string_literal: true

class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car_category

  default_scope -> { order start_date: :desc }

  before_create :generate_token

  VALID_DATE_REGEX = /\d{4}-\d{2}-\d{2}/.freeze
  validates :start_date, presence: true, format: { with: VALID_DATE_REGEX }
  validate :whether_start_date_is_either_today_or_in_the_future
  validates :end_date, presence: true, format: { with: VALID_DATE_REGEX }
  validate :whether_end_date_greater_than_start_date

  validates :customer, presence: true
  validates :car_category, presence: true

  private

  def generate_token
    self.token = loop do
      generated_token = SecureRandom.alphanumeric(5).upcase
      break generated_token unless Rental.exists? token: generated_token
    end
  end

  def whether_start_date_is_either_today_or_in_the_future
    return if start_date_is_before_today?

    errors.add :start_date, :cant_be_retroactive
  end

  def start_date_is_before_today?
    start_date && Date.today <= start_date
  end

  def whether_end_date_greater_than_start_date
    return if it_starts_before_it_ends?

    errors.add :end_date, :must_be_after_start_date
  end

  def it_starts_before_it_ends?
    start_date && end_date && start_date < end_date
  end
end
