# frozen_string_literal: true

class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find params[:id]
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new subsidiary_params
    if @subsidiary.save
      flash[:success] = t 'views.messages.successfully.created',
                          resource: t('activerecord.models.subsidiary.one')
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def edit
    @subsidiary = Subsidiary.find params[:id]
  end

  def update
    @subsidiary = Subsidiary.find params[:id]
    if @subsidiary.update subsidiary_params
      flash[:success] = t 'views.messages.successfully.updated',
                          resource: t('activerecord.models.subsidiary.one')
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    Subsidiary.find(params[:id]).destroy
    flash[:success] = t 'views.messages.successfully.removed',
                        resource: t('activerecord.models.subsidiary.one')
    redirect_to subsidiaries_url
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit :name, :cnpj, :address
  end
end
