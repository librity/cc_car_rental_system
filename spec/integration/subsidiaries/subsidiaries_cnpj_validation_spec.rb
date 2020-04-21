# frozen_string_literal: true

require 'rails_helper'

feature "Subsidiaries' cnpj should" do
  scenario 'be unique' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '04576557000126'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    click_on I18n.t('views.actions.go_back')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Budget'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '04576557000126'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 7182, Lincoln, NE'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blank or empty' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '   '
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'have 14 characters' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '045765570100161'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '0457570100161'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be a numerical integer' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '045B65570100161'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'not be blacklisted' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '77777777777777'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end

  scenario 'be valid' do
    visit root_path
    click_on I18n.t('activerecord.models.subsidiary.other')
    click_on I18n.t('views.actions.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Avis'
    fill_in I18n.t('activerecord.attributes.subsidiary.cnpj'), with: '04576557000128'
    fill_in I18n.t('activerecord.attributes.subsidiary.address'), with: 'Paper Street 1415, Calabasas, CA'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_css('div.alert-danger', text: 'Este formulário contem')
  end
end
