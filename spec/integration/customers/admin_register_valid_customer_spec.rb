# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid customer' do
  scenario 'and name must be unique' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Johnny Smith'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
