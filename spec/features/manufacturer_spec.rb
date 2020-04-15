# frozen_string_literal: true

require 'rails_helper'

describe Manufacturer, type: :model do
  context 'validation' do
    it 'name cannot be blank' do
      manufacturer = Manufacturer.new

      manufacturer.valid?

      expect(manufacturer.errors[:name])
        .to include('Nome não pode ficar em branco')
    end

    it 'name must be unique' do
      Manufacturer.create!(name: 'Honda')
      manufacturer = Manufacturer.new(name: 'Honda')

      manufacturer.valid?

      expect(manufacturer.errors[:name]).to include('Nome deve ser único')
    end
  end
end
