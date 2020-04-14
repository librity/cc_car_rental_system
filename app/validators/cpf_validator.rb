# frozen_string_literal: true

# Validates the format of "Cadastro de Pessoas Fisicas", a Brazilian individual
# taxpayer registry identification for citizens and resident aliens, issued by
# the Brazilian Department of Federal Revenue.
class CpfValidator < ActiveModel::EachValidator
  BLACKLIST = %w[
    00000000000
    11111111111
    22222222222
    33333333333
    44444444444
    55555555555
    66666666666
    77777777777
    88888888888
    99999999999
    12345678909
    01234567890
  ].freeze

  def validate_each(record, attribute, value)
    return fail_validation(record, attribute) if value.blank?
    return fail_validation(record, attribute) if in_blacklist?(value)

    raw_cpf = parse_cpf(value)

    fail_validation(record, attribute) unless valid_digits?(raw_cpf)
  end

  private

  def fail_validation(record, attribute)
    record.errors[attribute] << (options[:message] || ' não é valido')
  end

  def in_blacklist?(raw_cpf)
    BLACKLIST.include?(raw_cpf)
  end

  def parse_cpf(value)
    value.each_char.to_a.map(&:to_i)
  end

  def valid_digits?(raw_cpf)
    digits = raw_cpf[0...9]
    digits << generate_verification_digit(digits)
    digits << generate_verification_digit(digits)

    digits[-2, 2] == raw_cpf[-2, 2]
  end

  def generate_verification_digit(digits)
    modulus = digits.size + 1

    multiplied = digits.map.each_with_index do |number, index|
      number * (modulus - index)
    end

    mod = multiplied.reduce(:+) % 11
    mod < 2 ? 0 : 11 - mod
  end
end
