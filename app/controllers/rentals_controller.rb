# frozen_string_literal: true

class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def search
    @rental = Rental.find_by token: params[:token].upcase

    if @rental
      redirect_to @rental
    else
      flash[:info] = t 'views.resources.rentals.rental_not_found'
      redirect_to rentals_path
    end
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

    return handle_unalterable_rental 'edit' if @rental.start_date < Date.today

    load_dependent_models
  end

  def update
    @rental = Rental.find params[:id]

    return handle_unalterable_rental 'edit' if @rental.start_date < Date.today

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

    return handle_unalterable_rental 'delete' if @rental.start_date < Date.today

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

  def handle_unalterable_rental action
    flash[:danger] = t "views.resources.rentals.cant_#{action}_past_rental"
    redirect_to @rental
  end
end
