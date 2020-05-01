# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Alamo'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Alamo')
  end

  scenario 'and name can not be blank' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and name must be unique' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Alamo'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
