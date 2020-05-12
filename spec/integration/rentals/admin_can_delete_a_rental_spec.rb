# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can delete a rental' do
  before :each do
    log_user_in!
  end

  scenario 'successfully' do
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
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq rentals_path
    expect(Rental.count).to eq 0
    expect(page).to have_content(I18n.t('views.resources.rentals.empty_resource'))
    expect(page).to have_content(I18n.t('views.messages.successfully.destroyed',
                                        resource: I18n.t('activerecord.models.rental.one')))
  end

  scenario "and it doesn't delete all of them" do
    john_smith = Customer.create! name: 'John Smith', email: 'valid@example.com',
                                  cpf: '64757188072'
    hannah_banana = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                     email: 'hannah@example.com'

    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0
    suv = CarCategory.create! name: 'SUV', daily_rate: 1.23, insurance: 4.52,
                              third_party_insurance: 16.61

    rental_a = Rental.new start_date: Date.today + 1.week, end_date: Date.today + 2.weeks,
                          customer: john_smith, car_category: sedan,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_a.save validate: false
    rental_b = Rental.new start_date: Date.today + 6.days, end_date: Date.today + 8.days,
                          customer: hannah_banana, car_category: suv,
                          token: SecureRandom.alphanumeric(5).upcase
    rental_b.save validate: false

    visit root_path
    click_on I18n.t('activerecord.models.rental.other')
    within "tr#rental-#{rental_a.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq rentals_path
    expect(page).to have_content(I18n.t('views.messages.successfully.destroyed',
                                        resource: I18n.t('activerecord.models.rental.one')))
    expect(Rental.count).to eq 1
    expect(page).not_to have_content rental_a.token
    expect(page).not_to have_content I18n.l(rental_a.start_date)
    expect(page).not_to have_content I18n.l(rental_a.end_date)
    expect(page).to have_content rental_b.token
    expect(page).to have_content I18n.l(rental_b.start_date)
    expect(page).to have_content I18n.l(rental_b.end_date)
  end

  scenario "and delete link doesn't appear if the end date has passed" do
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

    expect(page).to_not have_link I18n.t('views.actions.delete'), href: rental_path(rental_a)
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

    page.driver.delete rental_path(rental_a)
    visit page.driver.response.location

    expect(current_path).to eq rental_path(rental_a)
    expect(page).to_not have_link I18n.t('views.actions.delete'), href: rental_path(rental_a)
    expect(page).to have_content I18n.t('views.resources.rentals.cant_delete_past_rental')
  end
end
