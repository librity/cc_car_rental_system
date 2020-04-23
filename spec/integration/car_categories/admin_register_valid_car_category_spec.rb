# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and daily rate should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: -2.4
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: 28.5
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end

  scenario 'and insurance should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: -2.4
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: 28.5
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end

  scenario 'and third party insurance should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: 28.5
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: -2.4
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end
end
