# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit a car' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0
    ridgeline = CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                                 metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                                 fuel_type: 'gasolina', metric_city_milage: 14,
                                 metric_highway_milage: 18, engine: '1.3 L L13A I4'
    hertz = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                               address: 'Paper Street 49, Grand Junction, CO'
    car_a = Car.create! license_plate: 'ada1das', color: 'Azul', metric_milage: 2800,
                        car_model: ridgeline, subsidiary: hertz

    visit root_path
    click_on I18n.t('activerecord.models.car.other')
    within "tr#car-#{car_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.car.license_plate'), with: 'erre432'
    fill_in I18n.t('activerecord.attributes.car.metric_milage'), with: 3851
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('3851')
    expect(page).to have_content('erre432')
    expect(page).to have_content I18n.t('views.messages.successfully.updated',
                                        resource: I18n.t('activerecord.models.car.one'))
  end

  scenario 'and license plate can not be blank' do
    honda = Manufacturer.create! name: 'Honda'
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0
    ridgeline = CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                                 metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                                 fuel_type: 'gasolina', metric_city_milage: 14,
                                 metric_highway_milage: 18, engine: '1.3 L L13A I4'
    hertz = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                               address: 'Paper Street 49, Grand Junction, CO'
    car_a = Car.create! license_plate: 'ada1das', color: 'Azul', metric_milage: 2800,
                        car_model: ridgeline, subsidiary: hertz

    visit root_path
    click_on I18n.t('activerecord.models.car.other')
    within "tr#car-#{car_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.car.license_plate'), with: ''
    fill_in I18n.t('activerecord.attributes.car.metric_milage'), with: 3851
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and license plate must be unique' do
    honda = Manufacturer.create! name: 'Honda'
    fiat = Manufacturer.create! name: 'Fiat'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0

    uno = CarModel.create! name: 'Uno', year: '2019', manufacturer: fiat,
                           metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                           fuel_type: 'gasolina', metric_city_milage: 14,
                           metric_highway_milage: 18, engine: '1.3 L L13A I4'
    ridgeline = CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                                 metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                                 fuel_type: 'gasolina', metric_city_milage: 14,
                                 metric_highway_milage: 18, engine: '1.3 L L13A I4'

    hertz = Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                               address: 'Paper Street 49, Grand Junction, CO'
    alamo = Subsidiary.create! name: 'Alamo', cnpj: '35229090000171',
                               address: 'Paper Street 76, Alamo, TX'

    car_a = Car.create! license_plate: 'ada1das', color: 'Azul', metric_milage: 2800,
                        car_model: ridgeline, subsidiary: hertz
    Car.create! license_plate: 'gdf5213', color: 'Vermelho', metric_milage: 236_987,
                car_model: uno, subsidiary: alamo

    visit root_path
    click_on I18n.t('activerecord.models.car.other')
    within "tr#car-#{car_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.car.license_plate'), with: 'gdf5213'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
