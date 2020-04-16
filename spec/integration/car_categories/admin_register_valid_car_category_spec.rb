# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Registrar nova categoria de veículos'

    fill_in 'Nome', with: 'Sedan'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Registrar nova categoria de veículos'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
