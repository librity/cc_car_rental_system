# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on  I18n.t('views.resources.car_categories.plural')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Sedan'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.unique'))
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on  I18n.t('views.resources.car_categories.plural')
    click_on  I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.not_empty'))
  end
end
