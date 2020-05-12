# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a car category' do
  before :each do
    log_user_in!
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_car_category_path
  end

  scenario 'successfully' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Pickup'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: '120'
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: '30'
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: '40'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content I18n.t('views.messages.successfully.created',
                                        resource: I18n.t('activerecord.models.car_category.one'))
    expect(page).to have_content 'Pickup'
    expect(page).to have_content 'R$ 120'
    expect(page).to have_content 'R$ 30'
    expect(page).to have_content 'R$ 40'
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: car_categories_path
  end
end
