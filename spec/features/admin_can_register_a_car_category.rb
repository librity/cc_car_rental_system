# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car category' do
  scenario 'from index page' do
    visit root_path
    click_on 'Categorias de Veículos'

    expect(page).to have_link('Registrar nova categoria de veículos',
                              href: new_car_category_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Registrar nova categoria de veículos'

    fill_in 'Nome', with: 'Pickup'
    fill_in 'Diária', with: '120'
    fill_in 'Seguro', with: '30'
    fill_in 'Seguro de Terceiros', with: '40'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content('Pickup')
    expect(page).to have_content('120')
    expect(page).to have_content('30')
    expect(page).to have_content('40')
    expect(page).to have_link('Voltar')
  end
end
