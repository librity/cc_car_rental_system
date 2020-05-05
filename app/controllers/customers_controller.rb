# frozen_string_literal: true

class CustomersController < ApplicationController
  def index
    if params[:filter]
      like_filter_param = "%#{params[:filter].downcase}%"
      @customers = Customer.where 'name like ? OR cpf = ?',
                                  like_filter_param, params[:filter]
      if @customers.blank?
        @customers = Customer.all
        flash.now[:info] = t 'views.resources.customers.customer_not_found'
      end
    else
      @customers = Customer.all
    end
  end

  def show
    @customer = Customer.find params[:id]
    @upcoming_rentals = @customer.rentals.where 'DATE(start_date) >= ?', Date.today
    @past_rentals = @customer.rentals.where 'DATE(start_date) < ?', Date.today
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new customer_params
    if @customer.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.customer.one')
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find params[:id]
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update customer_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.customer.one')
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = t 'views.messages.successfully.destroyed',
                        resource: t('activerecord.models.customer.one')
    redirect_to customers_url
  end

  private

  def customer_params
    params.require(:customer).permit :name, :cpf, :email
  end
end
