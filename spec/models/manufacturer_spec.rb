# frozen_string_literal: true

require 'rails_helper'

describe Manufacturer, type: :model do
  subject do
    described_class.new(name: 'Honda')
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

    it 'must be unique' do
      subject.save!

      manufacturer = Manufacturer.new(name: 'Honda')

      expect(manufacturer).to_not be_valid
      expect(manufacturer.errors[:name]).to include('Nome deve ser único')
    end
  end
end
