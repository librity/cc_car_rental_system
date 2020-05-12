# frozen_string_literal: true

require 'rails_helper'

feature 'User can find a rental by its token' do
  before :each do
    log_user_in!
  end

  scenario 'successfully' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'
    hannah_banana = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                     email: 'hannah@example.com'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0
    suv = CarCategory.create! name: 'SUV', daily_rate: 1.23, insurance: 4.52,
                              third_party_insurance: 16.61

    rental_a = Rental.new start_date: Date.today - 5.weeks, end_date: Date.today - 4.weeks,
                          customer: john_smith, car_category: sedan
    rental_a.save validate: false
    rental_b = Rental.new start_date: Date.today - 3.weeks, end_date: Date.today - 17.days,
                          customer: hannah_banana, car_category: suv
    rental_b.save validate: false
    rental_c = Rental.new start_date: Date.today - 1.week, end_date: Date.today - 4.days,
                          customer: hannah_banana, car_category: sedan
    rental_c.save validate: false
    rental_d = Rental.new start_date: Date.today - 1.day, end_date: Date.today,
                          customer: john_smith, car_category: sedan
    rental_d.save validate: false
    rental_e = Rental.new start_date: Date.today - 1.day, end_date: Date.today + 2.days,
                          customer: hannah_banana, car_category: suv
    rental_e.save validate: false
    rental_f = Rental.new start_date: Date.today, end_date: Date.tomorrow,
                          customer: john_smith, car_category: sedan
    rental_f.save validate: false
    rental_g = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: suv
    rental_g.save validate: false
    rental_h = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 1.week + 1.day,
                          customer: john_smith, car_category: sedan
    rental_h.save validate: false

    visit root_path
    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: rental_c.token.downcase
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rental_path(rental_c)

    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: rental_b.token
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rental_path(rental_b)

    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: rental_h.token.downcase
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rental_path(rental_h)

    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: rental_e.token
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rental_path(rental_e)

    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: rental_a.token.downcase
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rental_path(rental_a)
  end

  scenario 'invalid token' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'
    hannah_banana = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                     email: 'hannah@example.com'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0
    suv = CarCategory.create! name: 'SUV', daily_rate: 1.23, insurance: 4.52,
                              third_party_insurance: 16.61

    rental_a = Rental.new start_date: Date.today - 5.weeks, end_date: Date.today - 4.weeks,
                          customer: john_smith, car_category: sedan
    rental_a.save validate: false
    rental_b = Rental.new start_date: Date.today - 3.weeks, end_date: Date.today - 17.days,
                          customer: hannah_banana, car_category: suv
    rental_b.save validate: false
    rental_c = Rental.new start_date: Date.today - 1.week, end_date: Date.today - 4.days,
                          customer: hannah_banana, car_category: sedan
    rental_c.save validate: false
    rental_d = Rental.new start_date: Date.today - 1.day, end_date: Date.today,
                          customer: john_smith, car_category: sedan
    rental_d.save validate: false
    rental_e = Rental.new start_date: Date.today - 1.day, end_date: Date.today + 2.days,
                          customer: hannah_banana, car_category: suv
    rental_e.save validate: false
    rental_f = Rental.new start_date: Date.today, end_date: Date.tomorrow,
                          customer: john_smith, car_category: sedan
    rental_f.save validate: false
    rental_g = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: suv
    rental_g.save validate: false
    rental_h = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 1.week + 1.day,
                          customer: john_smith, car_category: sedan
    rental_h.save validate: false

    visit root_path
    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: SecureRandom.alphanumeric(5)
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rentals_path
    expect(page).to have_content I18n.t('views.resources.rentals.rental_not_found')

    fill_in I18n.t('views.navigation.search_rentals_by_token'),
            with: SecureRandom.alphanumeric(5)
    click_on I18n.t('views.actions.search')

    expect(current_path).to eq rentals_path
    expect(page).to have_content I18n.t('views.resources.rentals.rental_not_found')
  end
end
