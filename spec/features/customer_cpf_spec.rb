# frozen_string_literal: true

require 'rails_helper'

feature "Customers' cpf should" do
  scenario 'be unique' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Ronnie Maldonado'
    fill_in 'Email', with: 'ronnie@example.com'
    fill_in 'CPF', with: '64757188072'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    click_on 'Voltar'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Julia Townsend'
    fill_in 'Email', with: 'julia@example.com'
    fill_in 'CPF', with: '64757188072'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'have 11 characters' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Ronnie Maldonado'
    fill_in 'Email', with: 'ronnie@example.com'
    fill_in 'CPF', with: '647718807212'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_content('Algo deu errado')

    fill_in 'Nome', with: 'Ronnie Maldonado'
    fill_in 'Email', with: 'ronnie@example.com'
    fill_in 'CPF', with: '6477188012'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'be valid' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Ronnie Maldonado'
    fill_in 'Email', with: 'ronnie@example.com'
    fill_in 'CPF', with: '85215440008'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_content('Algo deu errado')
  end
end
