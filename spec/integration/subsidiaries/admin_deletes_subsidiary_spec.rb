# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')

    visit root_path
    click_on 'Filiais'
    click_on 'Hertz'
    click_on 'Apagar filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario "and doesn't delete all of them" do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on 'Filiais'
    click_on 'Hertz'
    click_on 'Apagar filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).not_to have_content('Hertz')
    expect(page).to have_content('Alamo')
  end
end
