# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car model' do
  scenario 'and name can not be blank' do
    Manufacturer.create! name: 'Honda'
    CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    fill_in I18n.t('activerecord.attributes.car_model.year'), with: '2010'
    select 'Honda', from: I18n.t('activerecord.models.manufacturer.one')
    fill_in I18n.t('activerecord.attributes.car_model.metric_horsepower'), with: '135 @ 6500 rpm'
    select 'Sedan', from: I18n.t('activerecord.models.car_category.one')
    fill_in I18n.t('activerecord.attributes.car_model.fuel_type'), with: 'gasolina'
    fill_in I18n.t('activerecord.attributes.car_model.metric_city_milage'), with: '12'
    fill_in I18n.t('activerecord.attributes.car_model.metric_highway_milage'), with: '16'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
