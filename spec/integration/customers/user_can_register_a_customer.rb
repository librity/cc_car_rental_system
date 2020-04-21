# frozen_string_literal: true

require 'rails_helper'

feature 'Users can register a customer' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_client_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Andrew Dalton'
    fill_in I18n.t('views.labels.email'), with: 'andrew@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '14831482030'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    expect(page).to have_content('Andrew Dalton')
    expect(page).to have_content('andrew@example.com')
    expect(page).to have_content('14831482030')
    expect(page).to have_link('Voltar')
  end
end
