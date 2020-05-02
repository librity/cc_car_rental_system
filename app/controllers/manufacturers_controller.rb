# frozen_string_literal: true

class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find params[:id]
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new manufacturer_params
    if @manufacturer.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.manufacturer.one')
      redirect_to @manufacturer
    else
      render :new
    end
  end

  def edit
    @manufacturer = Manufacturer.find params[:id]
  end

  def update
    @manufacturer = Manufacturer.find params[:id]
    if @manufacturer.update manufacturer_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.manufacturer.one')
      redirect_to @manufacturer
    else
      render :edit
    end
  end

  def destroy
    Manufacturer.find(params[:id]).destroy
    flash[:success] = t 'views.messages.successfully.removed',
                        resource: t('activerecord.models.manufacturer.one')
    redirect_to manufacturers_url
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit :name
  end
end
