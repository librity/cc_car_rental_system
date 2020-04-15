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
      flash.now[:danger] = 'Algo deu errado'
      render :new
    end
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update(manufacturer_params)
      flash[:success] = 'Fabricante atualizado'
      redirect_to @manufacturer
    else
      flash.now[:danger] = 'Algo deu errado'
      render 'edit'
    end
  end

  def destroy
    Manufacturer.find(params[:id]).destroy
    flash[:success] = 'Fabricante removido'
    redirect_to manufacturers_url
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
