# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    click_on 'Sedan'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Camião'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Camião')
  end

  scenario 'and name can not be blank' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    click_on 'Sedan'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    click_on 'Sedan'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Camião'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
