# frozen_string_literal: true

require 'rails_helper'

describe Subsidiary, type: :model do
  context 'name validation' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name])
        .to include('Nome não pode ficar em branco')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Hertz', cnpj: '04576557000126')
      subsidiary = Subsidiary.new(name: 'Hertz', cnpj: '04576557000126')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome deve ser único')
    end
  end

  context 'cnpj validation' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj])
        .to include('Cnpj não pode ficar em branco')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Hertz', cnpj: '04576557000126')
      subsidiary = Subsidiary.new(name: 'Hertz', cnpj: '04576557000126')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('Cnpj deve ser único')
    end

    it 'must be valid' do
      subsidiary = Subsidiary.new(name: 'Hertz', cnpj: '04576558000126')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('Cnpj não é valido')
    end
  end
end
