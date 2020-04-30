# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes customer' do
  scenario 'successfully' do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq customers_path
    expect(Customer.count).to eq 0
    expect(page).to have_content(I18n.t('views.resources.customers.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'
    Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                     email: 'hannah@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq customers_path
    expect(Customer.count).to eq 1
    expect(page).not_to have_content('Johnny Smith')
    expect(page).to have_content('Hannah Banana')
  end
end
