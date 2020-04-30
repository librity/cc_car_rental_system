# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes car category' do
  scenario 'successfully' do
    car_category_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                           insurance: 10.0, third_party_insurance: 5.0

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    within "tr#car-category-#{car_category_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_categories_path
    expect(CarCategory.count).to eq 0
    expect(page).to have_content(I18n.t('views.resources.car_categories.empty_resource'))
  end

  scenario "and doesn't delete all of them" do
    car_category_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                           insurance: 10.0, third_party_insurance: 5.0

    CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    within "tr#car-category-#{car_category_one.id}" do
      click_on I18n.t('views.actions.details')
    end
    click_on I18n.t('views.actions.delete')

    expect(current_path).to eq car_categories_path
    expect(CarCategory.count).to eq 1
    expect(page).not_to have_content('Sedan')
    expect(page).to have_content('Camião')
  end
end
