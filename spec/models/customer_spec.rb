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

  context 'validation: name' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
    end
  end

  context 'validation: email' do
    it 'cannot be blank' do
      subject.email = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include('Email não pode ficar em branco')
    end

    it 'cannot be too long' do
      subject.email = 'a' * 244 + '@example.com'

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include('Email muito longo')
    end

    it 'must be unique' do
      subject.save!

      customer = Customer.new(email: 'valid@example.com')

      expect(customer).to_not be_valid
      expect(customer.errors[:email]).to include('Email deve ser único')
    end

    it 'should accept valid addresses' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]

      valid_addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com foo@bar..com]

      invalid_addresses.each do |invalid_address|
        subject.email = invalid_address

        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include('Email não é valido')
      end
    end

    it 'should be saved as lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      subject.email = mixed_case_email

      subject.save
      expect(subject.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context 'validation: cpf' do
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
