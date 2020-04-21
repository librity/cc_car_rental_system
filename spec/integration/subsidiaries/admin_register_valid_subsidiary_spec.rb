# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Hertz', cnpj: '84105199000102',
                       address: 'Paper Street 49, Grand Junction, CO')

    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'Hertz'
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.unique'))
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.name.not_empty'))
  end
end
