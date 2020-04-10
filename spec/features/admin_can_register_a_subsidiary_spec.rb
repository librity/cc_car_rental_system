# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can register a subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial',
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'National'
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
