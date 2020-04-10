# frozen_string_literal: true

require 'rails_helper'

feature 'Users can browse customers' do
  scenario 'successfully' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com')

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Johnny Smith')
    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and view details' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Johnny Smith'

    expect(page).to have_content('Johnny Smith')
    expect(page).to have_content('84226580036')
    expect(page).to have_content('johny@example.com')

    expect(page).not_to have_content('Hannah Banana')
    expect(page).not_to have_content('20080287042')
    expect(page).not_to have_content('hannah@example.com')
  end

  scenario 'when no car categories were created' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end

  scenario 'and return to home page' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to clients page' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Johnny Smith'
    click_on 'Voltar'

    expect(current_path).to eq customers_path
  end
end
