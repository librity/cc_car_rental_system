# frozen_string_literal: true

require 'rails_helper'

describe CarCategory, type: :model do
  context 'name validation' do
    it 'cannot be blank' do
      car_category = CarCategory.new

      car_category.valid?

      expect(car_category.errors[:name])
        .to include('Nome não pode ficar em branco')
    end

    it 'must be unique' do
      CarCategory.create!(name: 'SUV')
      car_category = CarCategory.new(name: 'SUV')

      car_category.valid?

      expect(car_category.errors[:name]).to include('Nome deve ser único')
    end
  end
end
