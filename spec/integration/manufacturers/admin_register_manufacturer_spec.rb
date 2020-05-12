# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a manufacturer' do
  before :each do
    log_user_in!
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')

    expect(page).to have_link(I18n.t('views.navigation.new'),
                              href: new_manufacturer_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Fiat'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq manufacturer_path(Manufacturer.last.id)
    expect(page).to have_content I18n.t('views.messages.successfully.created',
                                        resource: I18n.t('activerecord.models.manufacturer.one'))
    expect(page).to have_content('Fiat')
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: manufacturers_path
  end
end
