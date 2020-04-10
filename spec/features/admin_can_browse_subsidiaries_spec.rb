# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Hertz', cnpj: '00000000000100',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '00000000000101',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Hertz')
    expect(page).to have_content('Alamo')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Hertz', cnpj: '00000000000100',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '00000000000101',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on 'Filiais'
    click_on 'Hertz'

    expect(page).to have_content('Hertz')
    expect(page).to have_content('00000000000100')
    expect(page).to have_content('Paper Street 49, Grand Junction, CO')
    expect(page).not_to have_content('Alamo')
    expect(page).not_to have_content('00000000000101')
    expect(page).not_to have_content('Paper Street 76, Alamo, TX')
  end

  scenario 'when no subisidiaries were created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Hertz', cnpj: '00000000000100',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '00000000000101',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Hertz', cnpj: '00000000000100',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '00000000000101',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on 'Filiais'
    click_on 'Hertz'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
