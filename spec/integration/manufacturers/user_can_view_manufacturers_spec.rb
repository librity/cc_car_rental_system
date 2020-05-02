# frozen_string_literal: true

require 'rails_helper'

feature 'User can view manufacturers' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    Manufacturer.create! name: 'Fiat'
    Manufacturer.create! name: 'Volkswagen'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Volkswagen')
  end

  scenario 'and view details' do
    manufacturer_one = Manufacturer.create! name: 'Fiat'
    Manufacturer.create! name: 'Volkswagen'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Volkswagen')
  end

  scenario 'and no manufacturers are created' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_content(I18n.t('views.resources.manufacturers.empty_resource'))
  end

  scenario 'and return to home page' do
    Manufacturer.create! name: 'Fiat'
    Manufacturer.create! name: 'Volkswagen'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    manufacturer_one = Manufacturer.create! name: 'Fiat'
    Manufacturer.create! name: 'Volkswagen'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq manufacturers_path
  end
end
