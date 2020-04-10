# frozen_string_literal: true

class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = 'Cliente criado com sucesso'
      redirect_to @customer
    else
      flash.now[:error] = 'Algo deu errado'
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :cpf, :email)
  end
end
