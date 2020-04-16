# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits customer' do
  scenario 'successfully' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Johnny Smith'
    click_on 'Editar'
    fill_in 'Nome', with: 'Hannah Banana'
    click_on 'Enviar'

    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and name can not be blank' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Johnny Smith'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Johnny Smith'
    click_on 'Editar'
    fill_in 'Nome', with: 'Hannah Banana'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end
end
