# frozen_string_literal: true

require 'rails_helper'

describe Customer, type: :model do
  subject do
    described_class.new(name: 'John Smith',
                        email: 'valid@example.com',
                        cpf: '64757188072')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'name validation' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include('Nome não pode ficar em branco')
    end
  end

  context 'email validation' do
    it 'cannot be blank' do
      subject.email = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include('Email não pode ficar em branco')
    end

    it 'must be unique' do
      subject.save!

      customer = Customer.new(email: 'valid@example.com')

      expect(customer).to_not be_valid
      expect(customer.errors[:email]).to include('Email deve ser único')
    end

    it 'must be valid' do
      subject.email = 'invalidexample.com'

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include('Email não é valido')

      subject.save!
    end
  end

  context 'cpf validation' do
    it 'cannot be blank' do
      subject.cpf = ' '

      expect(subject).to_not be_valid

      expect(subject.errors[:cpf]).to include('Cpf não pode ficar em branco')
    end

    it 'must be unique' do
      subject.save!

      customer = Customer.new(cpf: '64757188072')

      expect(customer).to_not be_valid
      expect(customer.errors[:cpf]).to include('Cpf deve ser único')
    end

    it 'must be valid' do
      subject.cpf = '64757178072'

      expect(subject).to_not be_valid
      expect(subject.errors[:cpf]).to include('Cpf não é valido')
    end
  end
end
