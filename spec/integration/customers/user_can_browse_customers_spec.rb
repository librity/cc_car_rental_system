# frozen_string_literal: true

require 'rails_helper'

feature 'Users can browse customers' do
  scenario 'successfully' do
    Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com'
    Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')

    expect(page).to have_content('Johnny Smith')
    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and view details' do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'
    customer_two = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                    email: 'hannah@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_content('Johnny Smith')
    expect(page).to have_content(customer_one.formatted_cpf)
    expect(page).to have_content('johny@example.com')

    expect(page).not_to have_content('Hannah Banana')
    expect(page).not_to have_content(customer_two.formatted_cpf)
    expect(page).not_to have_content('hannah@example.com')
  end

  scenario 'when no car categories were created' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')

    expect(page).to have_content(I18n.t('views.resources.customers.empty_resource'))
  end

  scenario 'and return to home page' do
    Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com'
    Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to clients page' do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'
    Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq customers_path
  end
end
