# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    manufacturer_one = Manufacturer.create! name: 'Fiat'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq manufacturers_path
    expect(page).to have_content(I18n.t('views.resources.manufacturers.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    manufacturer_one = Manufacturer.create! name: 'Fiat'
    Manufacturer.create! name: 'Honda'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq manufacturers_path
    expect(page).not_to have_content('Fiat')
    expect(page).to have_content('Honda')
  end
end
