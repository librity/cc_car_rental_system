# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse car models' do
  scenario 'successfully' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 12,
                     metric_highway_milage: 16)
    CarModel.create!(name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')

    expect(page).to have_content('Civic')
    expect(page).to have_content('Fit')
  end

  scenario 'and view details' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    car_model_one = CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16)
    CarModel.create!(name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.actions.details')
    end

    expect(page).to have_content('Civic')
    expect(page).to have_content('2010')
    expect(page).to have_content('Honda')
    expect(page).to have_content('135 @ 6500 rpm')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('gasolina')
    expect(page).to have_content('12')
    expect(page).to have_content('16')
    expect(page).not_to have_content('Fit')
    expect(page).not_to have_content('2005')
    expect(page).not_to have_content('120 @ 6500 rpm')
    expect(page).not_to have_content('14')
    expect(page).not_to have_content('18')
  end

  scenario 'when no car models were created' do
    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')

    expect(page).to have_content(I18n.t('views.resources.car_models.empty_resource'))
  end

  scenario 'and return to home page' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 12,
                     metric_highway_milage: 16)
    CarModel.create!(name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    click_on I18n.t('views.actions.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to car models page' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    car_model_one = CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16)
    CarModel.create!(name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18)

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.go_back')

    expect(current_path).to eq car_models_path
  end
end
