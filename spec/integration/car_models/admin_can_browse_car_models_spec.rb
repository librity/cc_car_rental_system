# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse car models' do
  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    ford = Manufacturer.create! name: 'Ford'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 12,
                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    CarModel.create! name: 'Ka', year: '2005', manufacturer: ford,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')

    expect(page).to have_content('Honda')
    expect(page).to have_content('Civic')
    expect(page).to have_content('2010')

    expect(page).to have_content('Ford')
    expect(page).to have_content('Ka')
    expect(page).to have_content('2005')
  end

  scenario 'and view details' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    car_model_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    CarModel.create! name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_content('Civic')
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.year'}: 2010"

    expect(page).to have_content "#{I18n.t 'activerecord.models.manufacturer.one'}: Honda"
    expect(page).to have_content "#{I18n.t 'activerecord.models.car_category.one'}: Sedan"
    expect(page)
      .to have_content "#{I18n.t 'activerecord.attributes.car_category.daily_rate'}: R$ 100,00"
    expect(page)
      .to have_content "#{I18n.t 'activerecord.attributes.car_category.insurance'}: R$ 10,00"
    expect(page)
      .to have_content "#{I18n.t 'activerecord.attributes.car_category.third_party_insurance'}: R$ 5,00"

    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.metric_horsepower'}: 135 @ 6500 rpm"
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.fuel_type'}: gasolina"
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.metric_city_milage'}: 12"
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.metric_highway_milage'}: 16"
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.car_model.engine'}: 1.6 L R16A1 I4"

    expect(page).not_to have_content('Fit')
    expect(page).not_to have_content('2005')
    expect(page).not_to have_content('120 @ 6500 rpm')
    expect(page).not_to have_content('14')
    expect(page).not_to have_content('18')
    expect(page).not_to have_content('1.3 L L13A I4')
  end

  scenario 'when no car models were created' do
    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')

    expect(page).to have_content(I18n.t('views.resources.car_models.empty_resource'))
  end

  scenario 'and return to home page' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 12,
                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    CarModel.create! name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to car models page' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    car_model_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    CarModel.create! name: 'Fit', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq car_models_path
  end
end
