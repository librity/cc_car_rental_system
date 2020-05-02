# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete a car model' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    car_model_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_models_path
    expect(CarModel.count).to eq 0
    expect(page).to have_content(I18n.t('views.resources.car_models.empty_resource'))
    expect(page).to have_content(I18n.t('views.messages.successfully.destroyed',
                                        resource: I18n.t('activerecord.models.car_model.one')))
  end

  scenario "and doesn't delete all of them" do
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
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_models_path
    expect(page).to have_content(I18n.t('views.messages.successfully.destroyed',
                                        resource: I18n.t('activerecord.models.car_model.one')))
    expect(CarModel.count).to eq 1
    expect(page).not_to have_content('Civic')
    expect(page).to have_content('Fit')
  end
end
