# frozen_string_literal: true

require 'rails_helper'

describe Customer, type: :model do
  context 'name validation' do
    it 'cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:name])
        .to include('Nome não pode ficar em branco')
    end

    it 'must be unique' do
      Customer.create!(name: 'John')
      customer = Customer.new(name: 'John')

      customer.valid?

      expect(customer.errors[:name]).to include('Nome deve ser único')
    end
  end

  context 'cpf validation' do
    it 'cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:cpf]).to include('Cpf não pode ficar em branco')
    end

    it 'must be unique' do
      Customer.create!(name: 'John', cpf: '64757188072')
      customer = Customer.new(name: 'John', cpf: '64757188072')

      customer.valid?

      expect(customer.errors[:cpf]).to include('Cpf deve ser único')
    end

    it 'must be valid' do
      customer = Customer.new(name: 'John', cpf: '64757178072')

      customer.valid?

      expect(customer.errors[:cpf]).to include('Cpf não é valido')
    end
  end
end
