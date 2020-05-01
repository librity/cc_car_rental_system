# frozen_string_literal: true

require 'rails_helper'

feature 'Users views home page' do
  context 'when not logged in' do
    scenario 'successfully' do
      visit root_path

      expect(page).to have_link I18n.t('views.navigation.home')
      expect(page).to have_link href: root_path, count: 3

      expect(page).to have_content I18n.t('views.application_name')
      expect(page).to have_content I18n.t('views.greeting')
    end
  end
end
