# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')

    expect(page).to have_link(I18n.t('views.actions.new'),
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('views.resources.subsidiaries.plural')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('views.labels.name'), with: 'National'
    fill_in 'CNPJ', with: '35229090000171'
    fill_in 'Endereço', with: 'Paper Street 123, Portland, OR'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('National')
    expect(page).to have_content('35229090000171')
    expect(page).to have_content('Paper Street 123, Portland, OR')
    expect(page).to have_link('Voltar')
  end
end
