# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'successfully' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    car_model_one = CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Fit'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Fit')
  end

  scenario 'and name can not be blank' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    car_model_one = CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
