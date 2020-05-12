# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car' do
  before :each do
    log_user_in!
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.car.other')

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_car_path
  end

  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0
    CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'
    Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on  I18n.t('activerecord.models.car.other')
    click_on  I18n.t('views.navigation.new')

    select 'Ridgeline', from: I18n.t('activerecord.models.car_model.one')
    select 'Hertz', from: I18n.t('activerecord.models.subsidiary.one')
    fill_in I18n.t('activerecord.attributes.car.license_plate'), with: 'ada1das'
    fill_in I18n.t('activerecord.attributes.car.color'), with: 'Azul'
    fill_in I18n.t('activerecord.attributes.car.metric_milage'), with: 2800
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq car_path(Car.last.id)
    expect(page).to have_content I18n.t('views.messages.successfully.created',
                                        resource: I18n.t('activerecord.models.car.one'))
    expect(page).to have_css('header h1', text: "#{I18n.t 'views.resources.cars.show_header'} ada1das")
    expect(page).to have_content 'Azul'
    expect(page).to have_content '2800'
    expect(page).to have_content 'Honda'
    expect(page).to have_content 'Ridgeline'
    expect(page).to have_content 'Hertz'

    expect(page).to have_link I18n.t('views.navigation.go_back'), href: cars_path
  end

  scenario 'and metric milage should be greater than or equal to zero' do
    honda = Manufacturer.create! name: 'Honda'
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0
    CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                     metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                     fuel_type: 'gasolina', metric_city_milage: 14,
                     metric_highway_milage: 18, engine: '1.3 L L13A I4'
    Subsidiary.create! name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO'

    visit root_path
    click_on  I18n.t('activerecord.models.car.other')
    click_on  I18n.t('views.navigation.new')

    select 'Ridgeline', from: I18n.t('activerecord.models.car_model.one')
    select 'Hertz', from: I18n.t('activerecord.models.subsidiary.one')
    fill_in I18n.t('activerecord.attributes.car.license_plate'), with: 'ada1das'
    fill_in I18n.t('activerecord.attributes.car.color'), with: 'Azul'
    fill_in I18n.t('activerecord.attributes.car.metric_milage'), with: -234
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than_or_equal_to', count: 0))
  end
end
