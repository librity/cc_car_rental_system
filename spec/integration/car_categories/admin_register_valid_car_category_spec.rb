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
end
