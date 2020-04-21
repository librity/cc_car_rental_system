# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_manufacturer_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Fiat'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq manufacturer_path(Manufacturer.last.id)
    expect(page).to have_content('Fiat')
    expect(page).to have_link(I18n.t('views.actions.go_back'))
  end
end
