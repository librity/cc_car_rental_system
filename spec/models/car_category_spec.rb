# frozen_string_literal: true

require 'rails_helper'

describe CarCategory, type: :model do
  subject do
    described_class.new(name: 'SUV', daily_rate: 1.23, insurance: 4.52,
                        third_party_insurance: 16.61)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: name' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be unique' do
      subject.save!

      car_category = CarCategory.new(name: 'SUV')

      expect(car_category).to_not be_valid
      expect(car_category.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end
  end

  context 'validation: daily_rate' do
    it 'cannot be blank' do
      subject.daily_rate = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:daily_rate]).to include(I18n.t('errors.messages.blank'))
    end
    
    it 'should be numerical' do
      subject.daily_rate = '12.B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:daily_rate])
        .to include(I18n.t('errors.messages.not_a_number'))
    end
  end

  context 'validation: insurance' do
    it 'cannot be blank' do
      subject.insurance = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:insurance]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.insurance = '12.B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:insurance])
        .to include(I18n.t('errors.messages.not_a_number'))
    end
  end

  context 'validation: third_party_insurance' do
    it 'cannot be blank' do
      subject.third_party_insurance = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:third_party_insurance]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.third_party_insurance = '12.B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:third_party_insurance])
        .to include(I18n.t('errors.messages.not_a_number'))
    end
  end
end
