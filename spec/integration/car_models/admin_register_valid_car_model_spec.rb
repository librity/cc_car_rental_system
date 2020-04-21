# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car model' do
  scenario 'and name can not be blank' do
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on 'Modelos de Veículos'
    click_on 'Registrar novo modelo de veículos'

    fill_in 'Nome', with: ''
    fill_in 'Ano', with: '2010'
    select 'Honda', from: 'Fabricante'
    fill_in 'Potência', with: '135 @ 6500 rpm'
    select 'Sedan', from: 'Categoria de veículo'
    fill_in 'Tipo de combustível', with: 'gasolina'
    fill_in 'Quilometragem na cidade', with: '12'
    fill_in 'Quilometragem na estrada', with: '16'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
