# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a rental' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.rental.other')

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_rental_path
  end

  scenario 'successfully' do
    customer = Customer.create! name: 'Fulano Sicrano',
                                cpf: '18597244003',
                                email: 'teste@teste.com.br'

    car_category = CarCategory.create! name: 'Camião', daily_rate: 112,
                                       insurance: 39,
                                       third_party_insurance: 184

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: '27/04/2030'
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: '29/04/2030'
    select customer.name, from: I18n.t('activerecord.models.customer.one')
    select car_category.name, from: I18n.t('activerecord.models.car_category.one')
    click_on I18n.t('views.actions.send')

    expect(page).to have_content "#{I18n.t 'activerecord.attributes.rental.start_date'}: 27/04/2030"
    expect(page).to have_content "#{I18n.t 'activerecord.attributes.rental.end_date'}: 29/04/2030"
    expect(page).to have_content "#{I18n.t 'activerecord.models.customer.one'}: #{customer.name}"
    expect(page).to have_content "#{I18n.t 'activerecord.models.car_category.one'}: #{car_category.name}"
  end

  scenario 'and must fill in all fields' do
    Customer.create! name: 'Fulano Sicrano',
                     cpf: '18597244003',
                     email: 'teste@teste.com.br'

    CarCategory.create! name: 'Camião', daily_rate: 112,
                        insurance: 39,
                        third_party_insurance: 184

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: '   '
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: ' '
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('errors.messages.blank'), count: 4
    expect(page).to have_content I18n.t('errors.messages.invalid'), count: 2
  end

  scenario 'and dates must be valid' do
    customer = Customer.create! name: 'Fulano Sicrano',
                                cpf: '18597244003',
                                email: 'teste@teste.com.br'

    car_category = CarCategory.create! name: 'Camião', daily_rate: 112,
                                       insurance: 39,
                                       third_party_insurance: 184

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: 'dsa211$'
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: '12323145'
    select customer.name, from: I18n.t('activerecord.models.customer.one')
    select car_category.name, from: I18n.t('activerecord.models.car_category.one')
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('errors.messages.invalid'), count: 2
  end

  scenario "and start date can't be retroactive" do
    customer = Customer.create! name: 'Fulano Sicrano',
                                cpf: '18597244003',
                                email: 'teste@teste.com.br'

    car_category = CarCategory.create! name: 'Camião', daily_rate: 112,
                                       insurance: 39,
                                       third_party_insurance: 184

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: Date.yesterday
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: '29/04/2030'
    select customer.name, from: I18n.t('activerecord.models.customer.one')
    select car_category.name, from: I18n.t('activerecord.models.car_category.one')
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('activerecord.errors.models.rental.attributes.start_date.cant_be_retroactive')
  end

  scenario 'and start date must be before end date' do
    customer = Customer.create! name: 'Fulano Sicrano',
                                cpf: '18597244003',
                                email: 'teste@teste.com.br'

    car_category = CarCategory.create! name: 'Camião', daily_rate: 112,
                                       insurance: 39,
                                       third_party_insurance: 184

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: '29/04/2030'
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: '28/04/2030'
    select customer.name, from: I18n.t('activerecord.models.customer.one')
    select car_category.name, from: I18n.t('activerecord.models.car_category.one')
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n
      .t('activerecord.errors.models.rental.attributes.end_date.must_be_after_start_date')
  end
end
