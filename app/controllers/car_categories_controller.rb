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
      flash[:success] = 'Categoria de veículo criada com sucesso'
      redirect_to @car_category
    else
      flash.now[:error] = 'Algo deu errado'
      render :new
    end
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :insurance,
                                         :third_party_insurance)
  end
end
