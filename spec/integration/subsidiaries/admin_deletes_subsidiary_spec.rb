# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes subsidiary' do
  scenario 'successfully' do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq subsidiaries_path
    expect(Subsidiary.count).to eq 0
    expect(page).to have_content(I18n.t('views.resources.subsidiaries.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    subsidiary_one = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                                        address: 'Paper Street 49, Grand Junction, CO'
    Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX'

    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    within "tr#subsidiary-#{subsidiary_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq subsidiaries_path
    expect(Subsidiary.count).to eq 1
    expect(page).not_to have_content('Hertz')
    expect(page).to have_content('Alamo')
  end
end
