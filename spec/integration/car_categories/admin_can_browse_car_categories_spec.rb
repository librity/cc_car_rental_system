# frozen_string_literal: true

require 'rails_helper'

feature 'Admins can browse car categories' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')

    expect(page).to have_content('Sedan')
    expect(page).to have_content('Camião')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('R$ 100')
    expect(page).to have_content('R$ 10')
    expect(page).to have_content('R$ 5')
    expect(page).not_to have_content('Camião')
    expect(page).not_to have_content('120')
    expect(page).not_to have_content('20')
    expect(page).not_to have_content('15')
  end

  scenario 'when no car categories were created' do
    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')

    expect(page).to have_content(I18n.t('views.resources.car_categories.empty_resource'))
  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to car categories page' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
