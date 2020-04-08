# frozen_string_literal: true

class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:success] = 'Fabricante criado com sucesso'
      redirect_to @manufacturer
    else
      flash.now[:error] = 'Algo deu errado'
      render :new
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
