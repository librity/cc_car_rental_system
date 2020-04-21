# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on I18n.t('views.resources.manufacturers.plural')
    click_on 'Fiat'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq manufacturers_path
    expect(page).to have_content(I18n.t('views.resources.manufacturers.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on I18n.t('views.resources.manufacturers.plural')
    click_on 'Fiat'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq manufacturers_path
    expect(page).not_to have_content('Fiat')
    expect(page).to have_content('Honda')
  end
end
