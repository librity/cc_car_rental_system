# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid customer' do
  scenario 'and name can not be blank' do
    visit root_path
    click_on I18n.t('views.resources.customers.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: ''
    click_on 'Enviar'

    expect(page).to have_content(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
  end
end
