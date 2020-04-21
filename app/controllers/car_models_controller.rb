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
      flash[:success] = 'Modelo de veículos criado com sucesso'
      redirect_to @car_model
    else
      flash.now[:danger] = 'Algo deu errado'
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
      flash[:success] = 'Modelo de veículos atualizado'
      redirect_to @car_model
    else
      flash.now[:danger] = 'Algo deu errado'
      load_dependent_models
      render :edit
    end
  end

  def destroy
    CarModel.find(params[:id]).destroy
    flash[:success] = 'Modelo de veículos removido'
    redirect_to car_models_url
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :year, :manufacturer_id, :fuel_type,
                                      :metric_horsepower, :car_category_id,
                                      :metric_city_milage, :metric_highway_milage)
  end

  def load_dependent_models
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end
end
