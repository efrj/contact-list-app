class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless cpf_valid?(value)
      record.errors.add(attribute, 'is invalid')
    end
  end

  private

  def cpf_valid?(cpf)
    return false if cpf.nil?
    cpf = cpf.scan(/\d/).join
    return false if cpf.length != 11
    return false if cpf.chars.uniq.length == 1

    verification_digits = cpf[9..10]
    calculated_digits = calculate_verification_digits(cpf[0..8])
    verification_digits == calculated_digits
  end

  def calculate_verification_digits(digits)
    first_digit = calculate_verification_digit(digits)
    second_digit = calculate_verification_digit(digits + first_digit)
    first_digit + second_digit
  end
  
  def calculate_verification_digit(digits)
    factors = (2..(digits.length + 1)).to_a.reverse
    sum = digits.chars.each_with_index.map { |digit, i| digit.to_i * factors[i] }.sum
    remainder = sum % 11
    remainder < 2 ? '0' : (11 - remainder).to_s
  end
end
