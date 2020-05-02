# frozen_string_literal: true

require 'rails_helper'

feature 'Users views home page' do
  scenario 'when not logged in' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'when logged in' do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user

    visit root_path

    expect(page).to have_link I18n.t('views.navigation.home')
    expect(page).to have_link href: root_path, count: 3

    expect(page).to have_content I18n.t('views.application_name')
    expect(page).to have_content I18n.t('views.greeting')
    expect(page).to have_css 'img', count: 10

    expect(page).to have_content I18n.t('views.footer.message_1')
    expect(page).to have_link 'Luis Geniole', href: 'https://github.com/librity'
    expect(page).to have_content I18n.t('views.footer.message_2')
    expect(page).to have_link 'Treina Dev,', href: 'https://treinadev.com.br/'
    expect(page).to have_content I18n.t('views.footer.message_3')
    expect(page).to have_link 'Campus Code', href: 'https://www.campuscode.com.br/'

    expect(page).to have_link I18n.t('views.footer.original_repo'),
                              href: 'https://github.com/librity/campus_code_car_rental_system'
  end
end
