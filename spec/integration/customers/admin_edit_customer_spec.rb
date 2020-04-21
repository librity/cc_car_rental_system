# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits customer' do
  scenario 'successfully' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on 'Johnny Smith'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Hannah Banana'
    click_on 'Enviar'

    expect(page).to have_content('Hannah Banana')
  end

  scenario 'and name can not be blank' do
    Customer.create!(name: 'Johnny Smith', cpf: '84226580036',
                     email: 'johny@example.com')

    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on 'Johnny Smith'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.not_empty'))
  end
end
