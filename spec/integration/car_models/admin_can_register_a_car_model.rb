# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car model' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_car_model_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Civic'
    fill_in I18n.t('activerecord.attributes.car_model.year'), with: '2010'
    select 'Honda', from: I18n.t('activerecord.models.manufacturer.one')
    select 'Sedan', from: I18n.t('activerecord.models.car_category.one')
    fill_in I18n.t('activerecord.attributes.car_model.engine'), with: '1.6 L R16A1 I4'
    fill_in I18n.t('activerecord.attributes.car_model.power'), with: '135 @ 6500 rpm'
    fill_in I18n.t('activerecord.attributes.car_model.fuel_type'), with: 'gasolina'
    fill_in I18n.t('activerecord.attributes.car_model.metric_city_milage'), with: '12'
    fill_in I18n.t('activerecord.attributes.car_model.metric_highway_milage'), with: '16'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq car_model_path(CarModel.last.id)
    expect(page).to have_content('Civic')
    expect(page).to have_content('2010')
    expect(page).to have_content('Honda')
    expect(page).to have_content('135 @ 6500 rpm')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('gasolina')
    expect(page).to have_content('12')
    expect(page).to have_content('16')
    expect(page).to have_content('1.6 L R16A1 I4')
    expect(page).to have_link(I18n.t('views.actions.go_back'))
  end
end
