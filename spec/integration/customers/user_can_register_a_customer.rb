# frozen_string_literal: true

require 'rails_helper'

feature 'Users can register a customer' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_client_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Andrew Dalton'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'andrew@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '14831482030'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customer_path(Customer.last.id)
    expect(page).to have_content('Andrew Dalton')
    expect(page).to have_content('andrew@example.com')
    expect(page).to have_content('148.314.820-30')
    expect(page).to have_link I18n.t('views.actions.go_back'), href: customers_path
  end
end
