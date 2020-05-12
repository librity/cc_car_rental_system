# frozen_string_literal: true

require 'rails_helper'

feature "Customers' cpf should" do
  before :each do
    log_user_in!
  end

  scenario 'be unique' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '64757188072'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customer_path(Customer.last.id)
    click_on I18n.t('views.navigation.go_back')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Julia Townsend'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'julia@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '64757188072'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blank or empty' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '     '
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'have 11 characters' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '647718807212'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '6477188012'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be a numerical integer' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '6477188A7212'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blacklisted' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '77777777777'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be valid' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Ronnie Maldonado'
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'ronnie@example.com'
    fill_in I18n.t('activerecord.attributes.customer.cpf'), with: '85215440008'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq customers_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end
end
