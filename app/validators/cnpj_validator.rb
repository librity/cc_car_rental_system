# frozen_string_literal: true

# Validates the format of "Cadastro Nacional da Pessoa Juridica", a Brazilian
# taxpayer registry identification for businesses and companies, issued by the
# Brazilian Department of Federal Revenue.
class CnpjValidator < ActiveModel::EachValidator
  BLACKLIST = %w[
    00000000000000
    11111111111111
    22222222222222
    33333333333333
    44444444444444
    55555555555555
    66666666666666
    77777777777777
    88888888888888
    99999999999999
  ].freeze

  def validate_each(record, attribute, value)
    raw_cnpj = parse_cnpj(value)

    fail_validation(record, attribute) if in_blacklist(raw_cnpj)
    fail_validation(record, attribute) unless valid_digits?(raw_cnpj)
  end

  private

  def parse_cnpj(value)
    value.each_char.to_a.map(&:to_i)
  end

  def fail_validation(record, attribute)
    record.errors[attribute] << (options[:message] || ' não é valido')
  end

  def in_blacklist(raw_cnpj)
    BLACKLIST.include?(raw_cnpj)
  end

  def valid_digits?(raw_cnpj)
    digits = raw_cnpj[0...12]
    digits << generate_verification_digit(digits)
    digits << generate_verification_digit(digits)

    digits[-2, 2] == raw_cnpj[-2, 2]
  end

  def generate_verification_digit(digits)
    index = 2

    sum = digits.reverse.reduce(0) do |buffer, number|
      (buffer + number * index).tap do
        index = index == 9 ? 2 : index + 1
      end
    end

    mod = sum % 11
    mod < 2 ? 0 : 11 - mod
  end
end
