# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse car categories' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, car_insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, car_insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on 'Categorias de Veículos'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('Camião')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, car_insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, car_insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Sedan'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('100')
    expect(page).to have_content('10')
    expect(page).to have_content('5')
    expect(page).not_to have_content('Camião')
    expect(page).not_to have_content('120')
    expect(page).not_to have_content('20')
    expect(page).not_to have_content('15')
  end

  scenario 'when no car categories were created' do
    visit root_path
    click_on 'Categorias de Veículos'

    expect(page).to have_content('Nenhuma categoria de veículos cadastrada')
  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, car_insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, car_insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, car_insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, car_insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on 'Categorias de Veículos'
    click_on 'Sedan'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
