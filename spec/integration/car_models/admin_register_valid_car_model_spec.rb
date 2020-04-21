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
    fill_in 'Ano', with: '2010'
    select 'Honda', from: I18n.t('views.resources.manufacturers.singular')
    fill_in 'Potência', with: '135 @ 6500 rpm'
    select 'Sedan', from: I18n.t('views.resources.car_categories.singular')
    fill_in 'Tipo de combustível', with: 'gasolina'
    fill_in 'Quilometragem na cidade', with: '12'
    fill_in 'Quilometragem na estrada', with: '16'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.not_empty'))
  end
end
