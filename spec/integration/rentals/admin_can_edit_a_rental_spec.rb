# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit a rental' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'
    walcott_roper = Customer.create! name: 'Walcott Roper',
                                     cpf: '18597244003',
                                     email: 'teste@teste.com.br'

    truck = CarCategory.create! name: 'Camião', daily_rate: 112,
                                insurance: 39,
                                third_party_insurance: 184
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false
    initial_token = rental_a.token

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: Date.tomorrow
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: Date.today + 3.days
    select walcott_roper.name, from: I18n.t('activerecord.models.customer.one')
    select truck.name, from: I18n.t('activerecord.models.car_category.one')
    click_on I18n.t('views.actions.send')

    expect(page).to have_content initial_token
    expect(page).to have_content I18n.l(Date.tomorrow)
    expect(page).to have_content I18n.l(Date.today + 3.days)
    expect(page).to have_content walcott_roper.name
    expect(page).to have_content truck.name
    expect(page).to have_content I18n.t('views.messages.successfully.updated',
                                        resource: I18n.t('activerecord.models.rental.one'))
  end

  scenario "and dates can't be blank" do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: '  '
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: '  '
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario "and start date can't be retroactive" do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: Date.yesterday
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('activerecord.errors.models.rental.attributes.start_date.cant_be_retroactive')
  end

  scenario 'and start date must be before end date' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')

    fill_in I18n.t('activerecord.attributes.rental.start_date'), with: Date.today + 1.week
    fill_in I18n.t('activerecord.attributes.rental.end_date'), with: Date.today + 6.days
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n
      .t('activerecord.errors.models.rental.attributes.end_date.must_be_after_start_date')
  end

  scenario "and edit link doesn't appear if the end date has passed" do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today - 1.week, end_date: Date.yesterday,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to_not have_link I18n.t('views.navigation.edit'), href: edit_rental_path(rental_a)
  end

  scenario 'and gets redirected to show rental with message if the end date has passed' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today - 1.week, end_date: Date.yesterday,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false

    visit edit_rental_path(rental_a)

    expect(current_path).to eq rental_path(rental_a)
    expect(page).to_not have_link I18n.t('views.navigation.edit'), href: edit_rental_path(rental_a)
    expect(page).to have_content I18n.t('views.resources.rentals.cant_edit_past_rental')
  end
end
