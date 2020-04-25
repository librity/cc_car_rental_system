# frozen_string_literal: true

require 'rails_helper'

feature 'Visitors should get a home page' do
  scenario 'success' do
    visit root_path

    expect(page).to have_content I18n.t('views.application_name')
    expect(page).to have_content I18n.t('views.greeting')
  end
end
