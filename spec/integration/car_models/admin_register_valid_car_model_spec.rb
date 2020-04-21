# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car model' do
  scenario 'and name can not be blank' do
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('views.resources.car_models.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: ''
    fill_in I18n.t('views.labels.year'), with: '2010'
    select 'Honda', from: I18n.t('views.resources.manufacturers.singular')
    fill_in I18n.t('views.labels.power'), with: '135 @ 6500 rpm'
    select 'Sedan', from: I18n.t('views.resources.car_categories.singular')
    fill_in I18n.t('views.labels.fuel_type'), with: 'gasolina'
    fill_in I18n.t('views.labels.metric_city_milage'), with: '12'
    fill_in I18n.t('views.labels.metric_highway_milage'), with: '16'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
  end
end
