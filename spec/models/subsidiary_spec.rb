# frozen_string_literal: true

require 'rails_helper'

describe Subsidiary, type: :model do
  subject do
    described_class.new(name: 'Hertz', cnpj: '84105199000102',
                        address: 'Paper Street 49, Grand Junction, CO')
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

      subsidiary = Subsidiary.new(name: 'Hertz')

      expect(subsidiary).to_not be_valid
      expect(subsidiary.errors[:name]).to include('Nome deve ser único')
    end
  end

  context 'validation: cnpj' do
    it 'cannot be blank' do
      subject.cnpj = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:cnpj]).to include('Cnpj não pode ficar em branco')
    end

    it 'must be unique' do
      subject.save!

      subsidiary = Subsidiary.new(cnpj: '84105199000102')

      expect(subsidiary).to_not be_valid
      expect(subsidiary.errors[:cnpj]).to include('Cnpj deve ser único')
    end

    it 'must be valid' do
      subject.cnpj = '84105199010102'

      expect(subject).to_not be_valid
      expect(subject.errors[:cnpj]).to include('Cnpj não é valido')
    end
  end
end
