# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register manufacturer' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
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
    expect(page).to have_content('Fiat')
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: manufacturers_path
  end
end
