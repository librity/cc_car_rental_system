# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).to have_content('Nenhum fabricante cadastrado')
  end

  scenario "and doesn't delete all of them" do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).not_to have_content('Fiat')
    expect(page).to have_content('Honda')
  end
end
