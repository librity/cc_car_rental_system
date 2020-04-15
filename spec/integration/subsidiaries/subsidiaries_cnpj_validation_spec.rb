# frozen_string_literal: true

require 'rails_helper'

feature "Subsidiaries' cnpj should" do
  scenario 'be unique' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '04576557000126'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    click_on 'Voltar'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Budget'
    fill_in 'CNPJ', with: '04576557000126'
    fill_in 'Endereço', with: 'Paper Street 7182, Lincoln, NE'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'not be blank or empty' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '   '
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'have 14 characters' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '045765570100161'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '0457570100161'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'be a numerical integer' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '045B65570100161'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'not be blacklisted' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '77777777777777'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end

  scenario 'be valid' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Avis'
    fill_in 'CNPJ', with: '04576557000128'
    fill_in 'Endereço', with: 'Paper Street 1415, Calabasas, CA'
    click_on 'Enviar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Algo deu errado')
  end
end
