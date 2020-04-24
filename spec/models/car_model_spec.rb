# frozen_string_literal: true

require 'rails_helper'

describe CarModel, type: :model do
  subject do
    honda = Manufacturer.create name: 'Honda'
    sedan = CarCategory.create name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                               third_party_insurance: 5.0

    described_class.new name: 'Civic', year: '2010', manufacturer: honda,
                        metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                        fuel_type: 'gasolina', metric_city_milage: 12,
                        metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
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
  end

  context 'validation: year' do
    it 'cannot be blank' do
      subject.year = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include(I18n.t('errors.messages.blank'))
    end

    it 'should have 4 digits' do
      subject.year = '12345'

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include(I18n.t('errors.messages.wrong_length.other', count: 4))

      subject.year = '123'

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include(I18n.t('errors.messages.wrong_length.other', count: 4))
    end

    it 'should be numerical' do
      subject.year = '12B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:year])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.year = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:year])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end

    it 'should be greater than 1960' do
      subject.year = '1960'

      expect(subject).to_not be_valid
      expect(subject.errors[:year])
        .to include(I18n.t('errors.messages.greater_than', count: 1960))
    end
  end

  context 'validation: manufacturer' do
    it 'cannot be blank' do
      subject.manufacturer = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:manufacturer])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: metric horsepower' do
    it 'cannot be blank' do
      subject.metric_horsepower = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_horsepower])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: car category' do
    it 'cannot be blank' do
      subject.car_category = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:car_category])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: fuel type' do
    it 'cannot be blank' do
      subject.fuel_type = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:fuel_type])
        .to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: metric city milage' do
    it 'cannot be blank' do
      subject.metric_city_milage = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.metric_city_milage = '1B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.metric_city_milage = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end
  end

  context 'validation: metric highway milage' do
    it 'cannot be blank' do
      subject.metric_highway_milage = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include(I18n.t('errors.messages.blank'))
    end

    it 'should be numerical' do
      subject.metric_highway_milage = '1B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include(I18n.t('errors.messages.not_a_number'))
    end

    it 'should be an integer' do
      subject.metric_highway_milage = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include(I18n.t('errors.messages.not_an_integer'))
    end
  end

  context 'validation: engine' do
    it 'cannot be blank' do
      subject.engine = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:engine])
        .to include(I18n.t('errors.messages.blank'))
    end
  end
end
