# frozen_string_literal: true

require 'rails_helper'

feature 'User browses rentals' do
  xscenario 'successfully' do
  end

  scenario 'and cannot  unless logged-in' do
    visit root_path

    expect(page).not_to have_link I18n.t('activerecord.models.rental.other')
  end

  scenario 'gets redirected to log in view if not logged-in' do
    visit rentals_path

    expect(current_path).to eq new_user_session_path
  end
end
