# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on I18n.t('views.resources.manufacturers.plural')
    click_on 'Fiat'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and name can not be blank' do
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on I18n.t('views.resources.manufacturers.plural')
    click_on 'Fiat'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
  end

  scenario 'and name must be unique' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')

    visit root_path
    click_on I18n.t('views.resources.manufacturers.plural')
    click_on 'Fiat'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')))
  end
end
