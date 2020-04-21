# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes customer' do
  scenario 'successfully' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on 'Johnny Smith'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq customers_path
    expect(page).to have_content('Nenhum cliente cadastrado')
  end

  scenario "and doesn't delete all of them" do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')
    Customer.create!(name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com')

    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on 'Johnny Smith'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq customers_path
    expect(page).not_to have_content('Johnny Smith')
    expect(page).to have_content('Hannah Banana')
  end
end
