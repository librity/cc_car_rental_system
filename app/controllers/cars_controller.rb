# frozen_string_literal: true

class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find params[:id]
  end

  def new
    @car = Car.new
    load_dependent_models
  end

  def create
    @car = Car.new car_params
    if @car.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.car.one')
      redirect_to @car
    else
      load_dependent_models
      render :new
    end
  end

  def edit
    @car = Car.find params[:id]
    load_dependent_models
  end

  def update
    @car = Car.find params[:id]
    if @car.update car_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.car.one')
      redirect_to @car
    else
      load_dependent_models
      render :edit
    end
  end

  def destroy
    Car.find(params[:id]).destroy
    flash[:success] = t 'views.messages.successfully.destroyed',
                        resource: t('activerecord.models.car.one')
    redirect_to cars_url
  end

  private

  def car_params
    params.require(:car).permit :license_plate, :color, :metric_milage,
                                :car_model_id, :subsidiary_id
  end

  def load_dependent_models
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end
end
