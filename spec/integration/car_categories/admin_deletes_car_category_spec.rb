# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_categories_path
    expect(page).to have_content(I18n.t('views.resources.car_categories.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Sedan')
    expect(page).to have_content('Camião')
  end
end
