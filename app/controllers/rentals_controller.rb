# frozen_string_literal: true

class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find params[:id]
  end

  def new
    @rental = Rental.new
    load_dependent_models
  end

  def create
    @rental = Rental.new rental_params
    if @rental.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.rental.one')
      redirect_to @rental
    else
      load_dependent_models
      render :new
    end
  end

  def edit
    @rental = Rental.find params[:id]

    if @rental.start_date < Date.today
      flash[:danger] = t 'views.resources.rentals.cant_edit_past_rental'
      return redirect_to @rental
    end

    load_dependent_models
  end

  def update
    @rental = Rental.find params[:id]

    if @rental.start_date < Date.today
      flash[:danger] = t 'views.resources.rentals.cant_edit_past_rental'
      return redirect_to @rental
    end

    if @rental.update rental_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.rental.one')
      redirect_to @rental
    else
      load_dependent_models
      render :edit
    end
  end

  def destroy
    @rental = Rental.find params[:id]

    if @rental.start_date < Date.today
      flash[:danger] = t 'views.resources.rentals.cant_delete_past_rental'
      return redirect_to @rental
    end

    @rental.destroy
    flash[:success] = t 'views.messages.successfully.destroyed',
                        resource: t('activerecord.models.rental.one')
    redirect_to rentals_url
  end

  private

  def rental_params
    params.require(:rental).permit :start_date, :end_date,
                                   :customer_id, :car_category_id
  end

  def load_dependent_models
    @customers = Customer.all
    @car_categories = CarCategory.all
  end
end
