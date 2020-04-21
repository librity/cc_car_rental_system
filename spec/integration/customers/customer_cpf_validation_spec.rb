# frozen_string_literal: true

require 'rails_helper'

feature "Customers' cpf should" do
  scenario 'be unique' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '64757188072'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    click_on 'Voltar'
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Julia Townsend'
    fill_in I18n.t('views.labels.email'), with: 'julia@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '64757188072'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blank or empty' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '     '
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'have 11 characters' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '647718807212'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '6477188012'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be a numerical integer' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '6477188A7212'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blacklisted' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '77777777777'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be valid' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('views.labels.email'), with: 'ronnie@example.com'
    fill_in I18n.t('views.labels.cpf'), with: '85215440008'
    click_on 'Enviar'

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end
end
