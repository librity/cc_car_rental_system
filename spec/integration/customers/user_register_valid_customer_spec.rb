# frozen_string_literal: true

require 'rails_helper'

feature 'Admin register valid customer' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on I18n.t('activerecord.models.customer.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
