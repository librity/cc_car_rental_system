# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a subsidiary' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')

    expect(page).to have_link(I18n.t('views.navigation.new'),
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'National'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '35229090000171'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 123, Portland, OR'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('National')
    expect(page).to have_content('35.229.090/0001-71')
    expect(page).to have_content('Paper Street 123, Portland, OR')
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: subsidiaries_path
  end
end
