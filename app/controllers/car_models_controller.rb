# frozen_string_literal: true

class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    load_dependent_models
  end

  def create
    @car_model = CarModel.new(car_model_params)
    if @car_model.save
      flash[:success] = t('views.messages.successfully.created',
                          resource: t('activerecord.models.car_model.one'))
      redirect_to @car_model
    else
      load_dependent_models
      render :new
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
    load_dependent_models
  end

  def update
    @car_model = CarModel.find(params[:id])
    if @car_model.update(car_model_params)
      flash[:success] = t('views.messages.successfully.updated',
                          resource: t('activerecord.models.car_model.one'))
      redirect_to @car_model
    else
      load_dependent_models
      render :edit
    end
  end

  def destroy
    CarModel.find(params[:id]).destroy
    flash[:success] = t('views.messages.successfully.removed',
                        resource: t('activerecord.models.car_model.one'))
    redirect_to car_models_url
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :year, :manufacturer_id, :fuel_type,
                                      :metric_horsepower, :car_category_id,
                                      :metric_city_milage, :metric_highway_milage,
                                      :engine)
  end

  def load_dependent_models
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end
end
