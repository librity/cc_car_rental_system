# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Hertz'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
