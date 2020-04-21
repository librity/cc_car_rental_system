# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Camião'
    click_on 'Enviar'

    expect(page).to have_content('Camião')
  end

  scenario 'and name can not be blank' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
  end

  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0)
    CarCategory.create!(name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0)

    visit root_path
    click_on I18n.t('views.resources.car_categories.plural')
    click_on 'Sedan'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Camião'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')))
  end
end
