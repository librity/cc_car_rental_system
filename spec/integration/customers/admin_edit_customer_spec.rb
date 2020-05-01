# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits customer' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Hannah Banana'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and name can not be blank' do
    customer_one = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                    email: 'johny@example.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{customer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
