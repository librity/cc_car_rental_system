# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car model' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('views.resources.car_models.plural')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_car_model_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('views.resources.car_models.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Civic'
    fill_in 'Ano', with: '2010'
    select 'Honda', from: I18n.t('views.resources.manufacturers.singular')
    fill_in 'Potência', with: '135 @ 6500 rpm'
    select 'Sedan', from: I18n.t('views.resources.car_categories.singular')
    fill_in 'Tipo de combustível', with: 'gasolina'
    fill_in 'Quilometragem na cidade', with: '12'
    fill_in 'Quilometragem na estrada', with: '16'
    click_on 'Enviar'

    expect(current_path).to eq car_model_path(CarModel.last.id)
    expect(page).to have_content('Civic')
    expect(page).to have_content('2010')
    expect(page).to have_content('Honda')
    expect(page).to have_content('135 @ 6500 rpm')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('gasolina')
    expect(page).to have_content('12')
    expect(page).to have_content('16')
    expect(page).to have_link('Voltar')
  end
end
