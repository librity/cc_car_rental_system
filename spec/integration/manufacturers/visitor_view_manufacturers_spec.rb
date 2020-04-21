# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Volkswagen')
  end

  scenario 'and view details' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Volkswagen')
  end

  scenario 'and no manufacturers are created' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_content(I18n.t('views.resources.manufacturers.empty_resource'))
  end

  scenario 'and return to home page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on I18n.t('views.actions.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on 'Fiat'
    click_on I18n.t('views.actions.go_back')

    expect(current_path).to eq manufacturers_path
  end
end
