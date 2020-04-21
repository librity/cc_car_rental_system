# frozen_string_literal: true

class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    if @car_category.save
      flash[:success] = 'Categoria de veículos criada com sucesso'
      redirect_to @car_category
    else
      render :new
    end
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(car_category_params)
      flash[:success] = 'Categoria de veículos atualizada'
      redirect_to @car_category
    else
      render :edit
    end
  end

  def destroy
    CarCategory.find(params[:id]).destroy
    flash[:success] = 'Categoria de veículos removida'
    redirect_to car_categories_url
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :insurance,
                                         :third_party_insurance)
  end
end
