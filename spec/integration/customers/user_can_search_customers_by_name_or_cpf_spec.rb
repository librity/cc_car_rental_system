# frozen_string_literal: true

require 'rails_helper'

feature 'User can filter customers ' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'by name and cpf successfully' do
    customer_a  = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                   email: 'johny@example.com'
    customer_b  = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                   email: 'hannah@example.com'
    customer_c  = Customer.create! name: 'Johnny Smith', cpf: '11233423770',
                                   email: 'Esta.Buckridge@yahoo.com'
    customer_d  = Customer.create! name: 'Janice Harris', cpf: '34137278504',
                                   email: 'Rolando_Kub@hotmail.com'
    customer_e  = Customer.create! name: 'Johnny Lemke', cpf: '44590008300',
                                   email: 'Mitchell.Stracke@gmail.com'
    customer_f  = Customer.create! name: 'James Hartmann', cpf: '05294059380',
                                   email: 'Joanie.Hartmann65@hotmail.com'
    customer_g  = Customer.create! name: 'Deven Bogisich', cpf: '47689725945',
                                   email: 'Deven51@yahoo.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')

    expect(page).to have_content customer_a.formatted_cpf
    expect(page).to have_content customer_b.formatted_cpf
    expect(page).to have_content customer_c.formatted_cpf
    expect(page).to have_content customer_d.formatted_cpf
    expect(page).to have_content customer_e.formatted_cpf
    expect(page).to have_content customer_f.formatted_cpf
    expect(page).to have_content customer_g.formatted_cpf

    expect(page).to have_text customer_a.name, count: 2
    expect(page).to have_content customer_b.name
    expect(page).to have_content customer_d.name
    expect(page).to have_content customer_e.name
    expect(page).to have_content customer_f.name
    expect(page).to have_content customer_g.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: customer_f.name
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content customer_f.formatted_cpf
    expect(page).not_to have_content customer_a.formatted_cpf
    expect(page).not_to have_content customer_b.formatted_cpf
    expect(page).not_to have_content customer_c.formatted_cpf
    expect(page).not_to have_content customer_d.formatted_cpf
    expect(page).not_to have_content customer_e.formatted_cpf
    expect(page).not_to have_content customer_g.formatted_cpf

    expect(page).to have_text customer_f.name, count: 1
    expect(page).not_to have_content customer_a.name
    expect(page).not_to have_content customer_b.name
    expect(page).not_to have_content customer_c.name
    expect(page).not_to have_content customer_d.name
    expect(page).not_to have_content customer_e.name
    expect(page).not_to have_content customer_g.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: 'johnny'
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content customer_a.formatted_cpf
    expect(page).to have_content customer_c.formatted_cpf
    expect(page).to have_content customer_e.formatted_cpf
    expect(page).not_to have_content customer_b.formatted_cpf
    expect(page).not_to have_content customer_d.formatted_cpf
    expect(page).not_to have_content customer_f.formatted_cpf
    expect(page).not_to have_content customer_g.formatted_cpf

    expect(page).to have_text customer_a.name, count: 2
    expect(page).to have_text customer_e.name, count: 1
    expect(page).not_to have_content customer_b.name
    expect(page).not_to have_content customer_d.name
    expect(page).not_to have_content customer_g.name
    expect(page).not_to have_content customer_f.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: customer_a.name
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content customer_a.formatted_cpf
    expect(page).to have_content customer_c.formatted_cpf
    expect(page).not_to have_content customer_b.formatted_cpf
    expect(page).not_to have_content customer_d.formatted_cpf
    expect(page).not_to have_content customer_e.formatted_cpf
    expect(page).not_to have_content customer_f.formatted_cpf
    expect(page).not_to have_content customer_g.formatted_cpf

    expect(page).to have_text customer_a.name, count: 2
    expect(page).not_to have_content customer_b.name
    expect(page).not_to have_content customer_d.name
    expect(page).not_to have_content customer_e.name
    expect(page).not_to have_content customer_f.name
    expect(page).not_to have_content customer_g.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: customer_g.cpf
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content customer_g.formatted_cpf
    expect(page).not_to have_content customer_a.formatted_cpf
    expect(page).not_to have_content customer_b.formatted_cpf
    expect(page).not_to have_content customer_c.formatted_cpf
    expect(page).not_to have_content customer_d.formatted_cpf
    expect(page).not_to have_content customer_e.formatted_cpf
    expect(page).not_to have_content customer_f.formatted_cpf

    expect(page).to have_text customer_g.name, count: 1
    expect(page).not_to have_content customer_a.name
    expect(page).not_to have_content customer_b.name
    expect(page).not_to have_content customer_c.name
    expect(page).not_to have_content customer_d.name
    expect(page).not_to have_content customer_e.name
    expect(page).not_to have_content customer_f.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: customer_d.cpf
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content customer_d.formatted_cpf
    expect(page).not_to have_content customer_a.formatted_cpf
    expect(page).not_to have_content customer_b.formatted_cpf
    expect(page).not_to have_content customer_c.formatted_cpf
    expect(page).not_to have_content customer_e.formatted_cpf
    expect(page).not_to have_content customer_f.formatted_cpf
    expect(page).not_to have_content customer_g.formatted_cpf

    expect(page).to have_text customer_d.name, count: 1
    expect(page).not_to have_content customer_a.name
    expect(page).not_to have_content customer_b.name
    expect(page).not_to have_content customer_c.name
    expect(page).not_to have_content customer_e.name
    expect(page).not_to have_content customer_f.name
    expect(page).not_to have_content customer_g.name
  end

  scenario "and renders a flash message when it doesn't find any" do
    customer_a  = Customer.create! name: 'Johnny Smith', cpf: '84226580036',
                                   email: 'johny@example.com'
    customer_b  = Customer.create! name: 'Hannah Banana', cpf: '20080287042',
                                   email: 'hannah@example.com'
    customer_c  = Customer.create! name: 'Johnny Smith', cpf: '11233423770',
                                   email: 'Esta.Buckridge@yahoo.com'
    customer_d  = Customer.create! name: 'Janice Harris', cpf: '34137278504',
                                   email: 'Rolando_Kub@hotmail.com'
    customer_e  = Customer.create! name: 'Johnny Lemke', cpf: '44590008300',
                                   email: 'Mitchell.Stracke@gmail.com'
    customer_f  = Customer.create! name: 'James Hartmann', cpf: '05294059380',
                                   email: 'Joanie.Hartmann65@hotmail.com'
    customer_g  = Customer.create! name: 'Deven Bogisich', cpf: '47689725945',
                                   email: 'Deven51@yahoo.com'

    visit root_path
    click_on I18n.t('activerecord.models.customer.other')

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: '80324244827'
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content I18n.t('views.resources.customers.customer_not_found')

    expect(page).to have_content customer_a.formatted_cpf
    expect(page).to have_content customer_b.formatted_cpf
    expect(page).to have_content customer_c.formatted_cpf
    expect(page).to have_content customer_d.formatted_cpf
    expect(page).to have_content customer_e.formatted_cpf
    expect(page).to have_content customer_f.formatted_cpf
    expect(page).to have_content customer_g.formatted_cpf

    expect(page).to have_content customer_a.name
    expect(page).to have_content customer_b.name
    expect(page).to have_content customer_c.name
    expect(page).to have_content customer_d.name
    expect(page).to have_content customer_e.name
    expect(page).to have_content customer_f.name
    expect(page).to have_content customer_g.name

    fill_in I18n.t('views.resources.customers.filter_customers'),
            with: 'tomsick'
    click_on I18n.t('views.actions.filter')

    expect(current_path).to eq customers_path
    expect(page).to have_content I18n.t('views.resources.customers.customer_not_found')

    expect(page).to have_content customer_a.formatted_cpf
    expect(page).to have_content customer_b.formatted_cpf
    expect(page).to have_content customer_c.formatted_cpf
    expect(page).to have_content customer_d.formatted_cpf
    expect(page).to have_content customer_e.formatted_cpf
    expect(page).to have_content customer_f.formatted_cpf
    expect(page).to have_content customer_g.formatted_cpf

    expect(page).to have_content customer_a.name
    expect(page).to have_content customer_b.name
    expect(page).to have_content customer_c.name
    expect(page).to have_content customer_d.name
    expect(page).to have_content customer_e.name
    expect(page).to have_content customer_f.name
    expect(page).to have_content customer_g.name
  end
end
