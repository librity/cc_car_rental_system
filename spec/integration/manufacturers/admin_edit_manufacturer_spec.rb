# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on 'Fiat'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Honda'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Honda')
  end

  scenario 'and name can not be blank' do
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on 'Fiat'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and name must be unique' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on 'Fiat'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Honda'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
