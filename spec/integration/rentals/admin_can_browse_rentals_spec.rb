# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse rentals' do
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
    click_on I18n.t('activerecord.models.rental.other')

    expect(page).to have_content rental_a.token
    expect(page).to have_content rental_b.token
    expect(page).to have_content rental_c.token
    expect(page).to have_content rental_d.token
    expect(page).to have_content rental_e.token
    expect(page).to have_content rental_f.token
    expect(page).to have_content rental_g.token
    expect(page).to have_content rental_h.token

    expect(page).to have_content I18n.l(rental_a.start_date)
    expect(page).to have_content I18n.l(rental_b.start_date)
    expect(page).to have_content I18n.l(rental_c.start_date)
    expect(page).to have_content I18n.l(rental_d.start_date)
    expect(page).to have_content I18n.l(rental_e.start_date)
    expect(page).to have_content I18n.l(rental_f.start_date)
    expect(page).to have_content I18n.l(rental_g.start_date)
    expect(page).to have_content I18n.l(rental_h.start_date)

    expect(page).to have_content I18n.l(rental_a.end_date)
    expect(page).to have_content I18n.l(rental_b.end_date)
    expect(page).to have_content I18n.l(rental_c.end_date)
    expect(page).to have_content I18n.l(rental_d.end_date)
    expect(page).to have_content I18n.l(rental_e.end_date)
    expect(page).to have_content I18n.l(rental_f.end_date)
    expect(page).to have_content I18n.l(rental_g.end_date)
    expect(page).to have_content I18n.l(rental_h.end_date)

    expect(page).to have_text john_smith.name, count: 5
    expect(page).to have_text hannah_banana.name, count: 3
  end

  scenario 'and view details' do
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

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end

    expect(page).to have_css('header h1', text: "#{I18n.t 'views.resources.rentals.show_header'} #{rental_a.token}")
    expect(page).to have_content I18n.l(rental_a.start_date)
    expect(page).to have_content I18n.l(rental_a.end_date)
    expect(page).to have_content 'John Smith'
    expect(page).to have_content '64757188072'
    expect(page).to have_content 'Sedan'
    expect(page).to have_content 'R$ 100,00'

    expect(page).to have_link(I18n.t('views.navigation.go_back'), href: rentals_path)

    expect(page).not_to have_content rental_b.token
    expect(page).not_to have_content I18n.l(rental_b.start_date)
    expect(page).not_to have_content I18n.l(rental_b.end_date)
    expect(page).not_to have_content 'Hannah Banana'
    expect(page).not_to have_content '20080287042'
    expect(page).not_to have_content 'SUV'
    expect(page).not_to have_content 'R$ 1,23'
  end

  scenario 'when no rentals were created' do
    visit root_path
    click_on I18n.t('activerecord.models.rental.other')

    expect(page).to have_content I18n.t('views.resources.rentals.empty_resource')
  end

  scenario 'and return to home page' do
    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq root_path
  end

  scenario 'and return to rentals page' do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    rental_a = Rental.new start_date: Date.today - 5.weeks, end_date: Date.today - 4.weeks,
                          customer: john_smith, car_category: sedan
    rental_a.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.go_back')

    expect(current_path).to eq rentals_path
  end
end
