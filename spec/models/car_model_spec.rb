# frozen_string_literal: true

require 'rails_helper'

describe CarModel, type: :model do
  subject do
    honda = Manufacturer.create(name: 'Honda')
    sedan = CarCategory.create(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                               third_party_insurance: 5.0)

    described_class.new(name: 'Civic', year: '2010', manufacturer: honda,
                        metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                        fuel_type: 'gas', metric_city_milage: 12,
                        metric_highway_milage: 16)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: name' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include('Nome não pode ficar em branco')
    end
  end

  context 'validation: year' do
    it 'cannot be blank' do
      subject.year = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include('Ano não pode ficar em branco')
    end

    it 'should have 4 digits' do
      subject.year = '12345'

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include('Ano tem que ter 4 digitos')

      subject.year = '123'

      expect(subject).to_not be_valid
      expect(subject.errors[:year]).to include('Ano tem que ter 4 digitos')
    end

    it 'should be numerical' do
      subject.year = '12B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:year])
        .to include('Ano tem que ser um número inteiro')
    end

    it 'should be an integer' do
      subject.year = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:year])
        .to include('Ano tem que ser um número inteiro')
    end
  end

  context 'validation: manufacturer' do
    it 'cannot be blank' do
      subject.manufacturer = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:manufacturer])
        .to include('Fabricante não pode ficar em branco')
    end
  end

  context 'validation: metric horsepower' do
    it 'cannot be blank' do
      subject.metric_horsepower = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_horsepower])
        .to include('Potência não pode ficar em branco')
    end
  end

  context 'validation: car category' do
    it 'cannot be blank' do
      subject.car_category = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:car_category])
        .to include('Categoria de veículo não pode ficar em branco')
    end
  end

  context 'validation: fuel type' do
    it 'cannot be blank' do
      subject.fuel_type = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:fuel_type])
        .to include('Tipo de combustível não pode ficar em branco')
    end
  end

  context 'validation: metric city milage' do
    it 'cannot be blank' do
      subject.metric_city_milage = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include('Quilometragem na cidade não pode ficar em branco')
    end

    it 'should be numerical' do
      subject.metric_city_milage = '1B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include('Quilometragem na cidade tem que ser um número inteiro')
    end

    it 'should be an integer' do
      subject.metric_city_milage = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_city_milage])
        .to include('Quilometragem na cidade tem que ser um número inteiro')
    end
  end

  context 'validation: metric highway milage' do
    it 'cannot be blank' do
      subject.metric_highway_milage = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include('Quilometragem na estrada não pode ficar em branco')
    end

    it 'should be numerical' do
      subject.metric_highway_milage = '1B4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include('Quilometragem na estrada tem que ser um número inteiro')
    end

    it 'should be an integer' do
      subject.metric_highway_milage = '12.4'

      expect(subject).to_not be_valid
      expect(subject.errors[:metric_highway_milage])
        .to include('Quilometragem na estrada tem que ser um número inteiro')
    end
  end
end
