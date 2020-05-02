# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register rental' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  xscenario 'successfully' do
    customer = Customer.create! name: 'Fulano Sicrano',
                                cpf: '18597244003',
                                email: 'teste@teste.com.br'

    car_category = CarCategory.create! name: 'A', daily_rate: 100,
                                       insurance: 100,
                                       third_party_insurance: 100

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

  xscenario 'and must fill in all fields' do
  end
end
