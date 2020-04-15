# frozen_string_literal: true

require 'rails_helper'

feature 'Visitors should get a home page' do
  scenario 'success' do
    visit root_path

    expect(page).to have_content('Car Rental System')
    expect(page).to have_content('Bem vindo ao sistema de gestão de locação')
  end
end
