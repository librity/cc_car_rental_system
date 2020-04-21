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
      expect(subject.errors[:name]).to include(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
    end

    it 'must be unique' do
      subject.save!

      manufacturer = Manufacturer.new(name: 'Honda')

      expect(manufacturer).to_not be_valid
      expect(manufacturer.errors[:name]).to include(I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')))
    end
  end
end
