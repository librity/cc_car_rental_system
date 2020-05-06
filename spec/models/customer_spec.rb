# frozen_string_literal: true

require 'rails_helper'

describe Customer, type: :model do
  subject do
    described_class.new name: 'John Smith',
                        email: 'valid@example.com',
                        cpf: '64757188072'
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

  context 'validation: email' do
    it 'cannot be blank' do
      subject.email = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it 'cannot be too long' do
      subject.email = 'a' * 244 + '@example.com'

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include(I18n.t('errors.messages.too_long', count: 255))
    end

    it 'must be unique' do
      subject.save!

      customer = described_class.new email: 'valid@example.com'

      expect(customer).to_not be_valid
      expect(customer.errors[:email]).to include(I18n.t('errors.messages.taken'))
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
        expect(subject.errors[:email]).to include(I18n.t('errors.messages.invalid'))
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

      expect(subject.errors[:cpf]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be unique' do
      subject.save!

      customer = described_class.new cpf: '64757188072'

      expect(customer).to_not be_valid
      expect(customer.errors[:cpf]).to include(I18n.t('errors.messages.taken'))
    end

    it 'must be valid' do
      subject.cpf = '64757178072'

      expect(subject).to_not be_valid
      expect(subject.errors[:cpf]).to include(I18n.t('errors.messages.invalid'))
    end
  end

  context 'scope: by_name_or_cpf' do
    it 'should filter by cpf' do
      subject.save!

      described_class.create! name: 'Wilhelmina Dennis',
                              email: 'maxie_bernhard@hotmail.com',
                              cpf: '03434365150'

      expect(described_class.by_name_or_cpf('64757188072')).to eq [subject]
    end

    it 'should filter by partial name' do
      subject.save!

      described_class.create! name: 'Wilhelmina Dennis',
                              email: 'maxie_bernhard@hotmail.com',
                              cpf: '03434365150'

      expect(described_class.by_name_or_cpf('ohn')).to eq [subject]
    end

    it 'should filter by case-insensitive name' do
      subject.save!

      described_class.create! name: 'Wilhelmina Dennis',
                              email: 'maxie_bernhard@hotmail.com',
                              cpf: '03434365150'

      expect(described_class.by_name_or_cpf('smith')).to eq [subject]
    end

    it "should return empty when customer doesn't exist" do
      subject.save!

      described_class.create! name: 'Wilhelmina Dennis',
                              email: 'maxie_bernhard@hotmail.com',
                              cpf: '03434365150'

      expect(described_class.by_name_or_cpf('senna')).to eq []
      expect(described_class.by_name_or_cpf('ja')).to eq []
      expect(described_class.by_name_or_cpf('68147210310')).to eq []
    end
  end

  context 'method: formatted_cpf' do
    it 'should format cpf' do
      expect(subject.formatted_cpf).to eq '647.571.880-72'
    end
  end
end
