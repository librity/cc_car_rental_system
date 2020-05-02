# frozen_string_literal: true

require 'rails_helper'

describe Car, type: :model do
  subject do
    honda = Manufacturer.create name: 'Honda'
    sedan = CarCategory.create name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                               third_party_insurance: 5.0

    civic = CarModel.create name: 'Civic', year: '2010', manufacturer: honda,
                            metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                            fuel_type: 'gasolina', metric_city_milage: 12,
                            metric_highway_milage: 16, engine: '1.6 L R16A1 I4'

    hertz = Subsidiary.create name: 'Hertz', cnpj: '84105199000102',
                              address: 'Paper Street 49, Grand Junction, CO'

    described_class.new license_plate: 'ada1das', color: 'Blue', metric_milage: 2800,
                        car_model: civic, subsidiary: hertz
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: license_plate' do
    it 'cannot be blank' do
      subject.license_plate = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:license_plate]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be unique' do
      subject.save!

      car = described_class.new license_plate: 'ada1das'

      expect(car).to_not be_valid
      expect(car.errors[:license_plate]).to include(I18n.t('errors.messages.taken'))
    end
  end

  context 'validation: color' do
    it 'cannot be blank' do
      subject.color = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:color]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: metric_milage' do
    it 'cannot be blank' do
      subject.metric_milage = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_milage]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.metric_milage = '1B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_milage])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.metric_milage = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_milage])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end

    it 'should be greater than or equal to zero' do
      subject.metric_milage = -12

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_milage])
        .to include(I18n.t('errors.messages.greater_than_or_equal_to', count: 0))
    end
  end

  context 'validation: car_model' do
    it 'cannot be blank' do
      subject.car_model = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:car_model])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: subsidiary' do
    it 'cannot be blank' do
      subject.subsidiary = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:subsidiary])
        .to include(I18n.t('errors.messages.blank'))
    end
  end
end
