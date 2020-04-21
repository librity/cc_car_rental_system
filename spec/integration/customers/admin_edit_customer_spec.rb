# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits customer' do
  scenario 'successfully' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on 'Johnny Smith'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Hannah Banana'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and name can not be blank' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on 'Johnny Smith'
    click_on I18n.t('views.actions.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
