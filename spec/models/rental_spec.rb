# frozen_string_literal: true

require 'rails_helper'

describe Rental, type: :model do
  subject do
    john_smith = Customer.new name: 'John Smith', email: 'valid@example.com',
                              cpf: '64757188072'

    sedan = CarCategory.create name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                               third_party_insurance: 5.0

    described_class.new start_date: Date.today, end_date: Date.tomorrow,
                        token: SecureRandom.alphanumeric(5).upcase,
                        customer: john_smith, car_category: sedan
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: start_date' do
    it 'cannot be blank' do
      subject.start_date = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:start_date]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be a date' do
      subject.start_date = '123123'

      expect(subject).to_not be_valid
      expect(subject.errors[:start_date]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must be in the future' do
      subject.start_date = Date.yesterday

      expect(subject).to_not be_valid
      expect(subject.errors[:start_date]).to include(I18n
        .t('activerecord.errors.models.rental.attributes.start_date.cant_be_retroactive'))
    end
  end

  context 'validation: end_date' do
    it 'cannot be blank' do
      subject.end_date = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:end_date]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be a date' do
      subject.end_date = 'qweq2321sae2e21eas'

      expect(subject).to_not be_valid
      expect(subject.errors[:end_date]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must be after start_date' do
      subject.end_date = subject.start_date

      expect(subject).to_not be_valid
      expect(subject.errors[:end_date]).to include(I18n
        .t('activerecord.errors.models.rental.attributes.end_date.must_be_after_start_date'))
    end
  end

  context 'validation: token' do
    it 'cannot be blank' do
      subject.token = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:token]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be unique' do
      subject.save!

      rental = described_class.new token: subject.token

      expect(rental).to_not be_valid
      expect(rental.errors[:token]).to include(I18n.t('errors.messages.taken'))
    end

    it 'must be 5 characters long' do
      subject.token = 'A4Q234'

      expect(subject).to_not be_valid
      expect(subject.errors[:token]).to include(I18n.t('errors.messages.wrong_length.other', count: 5))
    end

    it 'must be alphanumeric' do
      subject.token = 'A4%2='

      expect(subject).to_not be_valid
      expect(subject.errors[:token]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must must be uppercase' do
      subject.token = 'a4Q23'

      expect(subject).to_not be_valid
      expect(subject.errors[:token]).to include(I18n.t('errors.messages.invalid'))
    end
  end

  context 'validation: customer' do
    it 'cannot be blank' do
      subject.customer = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:customer])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: car_category' do
    it 'cannot be blank' do
      subject.car_category = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:car_category])
        .to include(I18n.t('errors.messages.blank'))
    end
  end
end
