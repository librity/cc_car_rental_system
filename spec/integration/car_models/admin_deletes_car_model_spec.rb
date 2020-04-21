# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes car model' do
  scenario 'successfully' do
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0)

    CarModel.create!(name: 'Civic', year: '2010', manufacturer: honda,
                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 12,
                     metric_highway_milage: 16)

    visit root_path
    click_on I18n.t('views.resources.car_models.plural')
    click_on 'Civic'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_models_path
    expect(page).to have_content('Nenhum modelo de veículos cadastrado')
  end

  scenario "and doesn't delete all of them" do
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
    click_on I18n.t('views.resources.car_models.plural')
    click_on 'Civic'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_models_path
    expect(page).not_to have_content('Civic')
    expect(page).to have_content('Fit')
  end
end
