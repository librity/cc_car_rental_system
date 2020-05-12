# frozen_string_literal: true

require 'rails_helper'

feature 'User can see customers rentals' do
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
    click_on I18n.t('activerecord.models.customer.other')
    within "tr#customer-#{john_smith.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_link I18n.l(rental_a.start_date), href: rental_path(rental_a)
    expect(page).to have_link I18n.l(rental_d.start_date), href: rental_path(rental_d)
    expect(page).to have_link I18n.l(rental_f.start_date), href: rental_path(rental_f)
    expect(page).to have_link I18n.l(rental_g.start_date), href: rental_path(rental_g)
    expect(page).to have_link I18n.l(rental_h.start_date), href: rental_path(rental_h)

    expect(page).not_to have_link I18n.l(rental_b.start_date), href: rental_path(rental_b)
    expect(page).not_to have_link I18n.l(rental_c.start_date), href: rental_path(rental_c)
    expect(page).not_to have_link I18n.l(rental_e.start_date), href: rental_path(rental_e)

    click_on I18n.t('views.navigation.go_back')
    within "tr#customer-#{hannah_banana.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_link I18n.l(rental_b.start_date), href: rental_path(rental_b)
    expect(page).to have_link I18n.l(rental_c.start_date), href: rental_path(rental_c)
    expect(page).to have_link I18n.l(rental_e.start_date), href: rental_path(rental_e)

    expect(page).not_to have_link I18n.l(rental_a.start_date), href: rental_path(rental_a)
    expect(page).not_to have_link I18n.l(rental_d.start_date), href: rental_path(rental_d)
    expect(page).not_to have_link I18n.l(rental_f.start_date), href: rental_path(rental_f)
    expect(page).not_to have_link I18n.l(rental_g.start_date), href: rental_path(rental_g)
    expect(page).not_to have_link I18n.l(rental_h.start_date), href: rental_path(rental_h)
  end
end
