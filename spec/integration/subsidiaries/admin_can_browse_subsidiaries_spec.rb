# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')

    expect(page).to have_content('Hertz')
    expect(page).to have_content('Alamo')
  end

  scenario 'and view details' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_content('Hertz')
    expect(page).to have_content('84.105.199/0001-02')
    expect(page).to have_content('Paper Street 49, Grand Junction, CO')
    expect(page).not_to have_content('Alamo')
    expect(page).not_to have_content('35229090000171')
    expect(page).not_to have_content('Paper Street 76, Alamo, TX')
  end

  scenario 'when no subisidiaries were created' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')

    expect(page).to have_content(I18n.t('views.resources.subsidiaries.empty_resource'))
  end

  scenario 'and return to home page' do
    Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq subsidiaries_path
  end
end
