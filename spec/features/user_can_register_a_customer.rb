# frozen_string_literal: true

require 'rails_helper'

feature 'Users can register a customer' do
  scenario 'from index page' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Registrar novo cliente',
                              href: new_client_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Andrew Dalton'
    fill_in 'Email', with: 'andrew@example.com'
    fill_in 'CPF', with: '00000000002'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    expect(page).to have_content('Andrew Dalton')
    expect(page).to have_content('andrew@example.com')
    expect(page).to have_content('00000000002')
    expect(page).to have_link('Voltar')
  end
end
