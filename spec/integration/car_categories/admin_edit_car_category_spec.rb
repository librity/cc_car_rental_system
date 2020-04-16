# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Sedan'
    click_on 'Editar'
    fill_in 'Nome', with: 'Camião'
    click_on 'Enviar'

    expect(page).to have_content('Camião')
  end

  scenario 'and name can not be blank' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Sedan'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Sedan'
    click_on 'Editar'
    fill_in 'Nome', with: 'Camião'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end
end
