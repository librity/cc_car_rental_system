# frozen_string_literal: true

require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')

    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on 'Hertz'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Alamo'
    click_on 'Enviar'

    expect(page).to have_content('Alamo')
  end

  scenario 'and name can not be blank' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')

    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on 'Hertz'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
  end

  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')
    Subsidiary.create!(name: 'Alamo', cnpj: '35229090000171',
                       address: 'Paper Street 76, Alamo, TX')

    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on 'Hertz'
    click_on 'Editar'
    fill_in I18n.t('views.labels.name'), with: 'Alamo'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')))
  end
end
