# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Hertz'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
