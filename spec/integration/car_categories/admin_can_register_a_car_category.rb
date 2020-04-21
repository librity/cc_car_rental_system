# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car category' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_car_category_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on  I18n.t('views.resources.car_categories.plural')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Pickup'
    fill_in I18n.t('views.labels.daily_rate'), with: '120'
    fill_in I18n.t('views.labels.insurance'), with: '30'
    fill_in I18n.t('views.labels.third_party_insurance'), with: '40'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content('Pickup')
    expect(page).to have_content('R$ 120')
    expect(page).to have_content('R$ 30')
    expect(page).to have_content('R$ 40')
    expect(page).to have_link('Voltar')
  end
end
