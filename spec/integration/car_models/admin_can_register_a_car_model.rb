# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car model' do
  scenario 'from index page' do
    visit root_path
    click_on 'Modelos de Veículos'

    expect(page).to have_link('Registrar novo modelo de veículos',
                              href: new_car_model_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Modelos de Veículos'
    click_on 'Registrar novo modelo de veículos'

    fill_in 'Nome', with: 'Civic'
    fill_in 'Ano', with: '2010'
    select 'Honda', from: 'Fabricante'
    fill_in 'Potência', with: '135 @ 6500 rpm'
    select 'Sedan', from: 'Categoria de veículo'
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
