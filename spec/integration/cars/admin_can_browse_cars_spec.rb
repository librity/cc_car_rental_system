# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse cars' do
  before :each do
    log_user_in!
  end

  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    fiat = Manufacturer.create! name: 'Fiat'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0

    civic = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                             metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                             fuel_type: 'gasolina', metric_city_milage: 12,
                             metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    fit = CarModel.create! name: 'Fit', year: '2005', manufacturer: honda,
                           metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                           fuel_type: 'gasolina', metric_city_milage: 14,
                           metric_highway_milage: 18, engine: '1.3 L L13A I4'
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

    Car.create! license_plate: 'ada1das', color: 'Azul', metric_milage: 2800,
                car_model: ridgeline, subsidiary: hertz
    Car.create! license_plate: 'vdar212', color: 'Caneta', metric_milage: 234,
                car_model: civic, subsidiary: hertz
    Car.create! license_plate: 'evvs242', color: 'Amarelo', metric_milage: 23_454,
                car_model: uno, subsidiary: hertz
    Car.create! license_plate: '234gfdr', color: 'Branco', metric_milage: 1235,
                car_model: civic, subsidiary: alamo
    Car.create! license_plate: '3dsa421', color: 'Cinza', metric_milage: 1222,
                car_model: ridgeline, subsidiary: alamo
    Car.create! license_plate: '234g433', color: 'Rosa', metric_milage: 1_122_432,
                car_model: uno, subsidiary: alamo
    Car.create! license_plate: '2fd4533', color: 'Preto', metric_milage: 45_654,
                car_model: civic, subsidiary: alamo
    Car.create! license_plate: '4dr4523', color: 'Amarelo', metric_milage: 4_323_255,
                car_model: fit, subsidiary: alamo
    Car.create! license_plate: '2345fds', color: 'Verde', metric_milage: 43_262,
                car_model: ridgeline, subsidiary: alamo
    Car.create! license_plate: '543dr43', color: 'Cinza', metric_milage: 234_254,
                car_model: uno, subsidiary: alamo
    Car.create! license_plate: 'gdf5213', color: 'Vermelho', metric_milage: 236_987,
                car_model: uno, subsidiary: alamo

    visit root_path
    click_on I18n.t('activerecord.models.car.other')

    expect(page).to have_content 'Honda Ridgeline 2005 Azul'
    expect(page).to have_content 'Honda Civic 2010 Caneta'
    expect(page).to have_content 'Fiat Uno 2019 Amarelo'
    expect(page).to have_content 'Honda Civic 2010 Branco'
    expect(page).to have_content 'Honda Ridgeline 2005 Cinza'
    expect(page).to have_content 'Fiat Uno 2019 Rosa'
    expect(page).to have_content 'Honda Civic 2010 Preto'
    expect(page).to have_content 'Honda Fit 2005 Amarelo'
    expect(page).to have_content 'Honda Ridgeline 2005 Verde'
    expect(page).to have_content 'Fiat Uno 2019 Cinza'
    expect(page).to have_content 'Fiat Uno 2019 Vermelho'

    expect(page).to have_content 'ada1das'
    expect(page).to have_content 'vdar212'
    expect(page).to have_content 'evvs242'
    expect(page).to have_content '234gfdr'
    expect(page).to have_content '3dsa421'
    expect(page).to have_content '234g433'
    expect(page).to have_content '2fd4533'
    expect(page).to have_content '4dr4523'
    expect(page).to have_content '2345fds'
    expect(page).to have_content '543dr43'
    expect(page).to have_content 'gdf5213'
  end

  scenario 'and view details' do
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

    expect(page).to have_css('header h1', text: "#{I18n.t 'views.resources.cars.show_header'} ada1das")
    expect(page).to have_content 'Azul'
    expect(page).to have_content '2800'
    expect(page).to have_content 'Honda'
    expect(page).to have_content 'Ridgeline'
    expect(page).to have_content 'Hertz'

    expect(page).to have_link(I18n.t('views.navigation.go_back'), href: cars_path)

    expect(page).not_to have_content 'gdf5213'
    expect(page).not_to have_content 'Vermelho'
    expect(page).not_to have_content '236987'
    expect(page).not_to have_content 'Fiat'
    expect(page).not_to have_content 'Uno'
    expect(page).not_to have_content 'Alamo'
  end

  scenario 'when no cars were created' do
    visit root_path
    click_on I18n.t('activerecord.models.car.other')

    expect(page).to have_content I18n.t('views.resources.cars.empty_resource')
  end

  scenario 'and return to home page' do
    visit root_path
    click_on I18n.t('activerecord.models.car.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to cars page' do
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
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq cars_path
  end
end
