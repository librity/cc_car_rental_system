# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse car categories' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'and view car models links inside a dropdown' do
    honda = Manufacturer.create! name: 'Honda'
    fiat = Manufacturer.create! name: 'Fiat'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                insurance: 10.0, third_party_insurance: 5.0
    truck = CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                                third_party_insurance: 15.0

    civic = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                             metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                             fuel_type: 'gasolina', metric_city_milage: 12,
                             metric_highway_milage: 16, engine: '1.6 L R16A1 I4'
    uno = CarModel.create! name: 'Uno', year: '2019', manufacturer: fiat,
                           metric_horsepower: '120 @ 6500 rpm', car_category: sedan,
                           fuel_type: 'gasolina', metric_city_milage: 14,
                           metric_highway_milage: 18, engine: '1.3 L L13A I4'

    ridgeline = CarModel.create! name: 'Ridgeline', year: '2005', manufacturer: honda,
                                 metric_horsepower: '120 @ 6500 rpm', car_category: truck,
                                 fuel_type: 'gasolina', metric_city_milage: 14,
                                 metric_highway_milage: 18, engine: '1.3 L L13A I4'

    visit car_categories_path

    within "tr#car-category-#{sedan.id}" do
      expect(page).to have_link 'Honda Civic 2010', href: car_model_path(civic)
      expect(page).to have_link 'Fiat Uno 2019', href: car_model_path(uno)

      expect(page).not_to have_link 'Honda Ridgeline 2005', href: car_model_path(ridgeline)
    end

    within "tr#car-category-#{truck.id}" do
      expect(page).to have_link 'Honda Ridgeline 2005', href: car_model_path(ridgeline)

      expect(page).not_to have_link 'Honda Civic 2010', href: car_model_path(civic)
      expect(page).not_to have_link 'Fiat Uno 2019', href: car_model_path(uno)
    end
  end
end
