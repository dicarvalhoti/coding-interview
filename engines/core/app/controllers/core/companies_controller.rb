
  module Core
  class CompaniesController < ApplicationController
    include Pagy::Backend


    def index
      companies = Company.search(params[:q]) if params[:q].present?
      companies ||= Company.all
      
      @pagy, @companies = pagy(companies, items: 5)


    end

    def show
      @company = Company.find(params[:id])
    end

    def add 
      @company = Company.new
    end

    def create 
      @company = Company.new(company_params)
      if @company.save
        redirect_to @company, notice: 'Company was successfully created.'
      else
        flash.now[:alert] = "Error creating Company: #{@company.errors.full_messages.join(', ')}"
        render :add
      end
    end

    def edit 
      @company = Company.find(params[:id])
    end

    def update_data 
      @company = Company.find(params[:id])
      if @company.update(company_params)
        redirect_to @company, notice: 'Company was successfully updated.'
      else
        flash.now[:alert] = "Error updating Company: #{@company.errors.full_messages.join(', ')}"
        render :edit
      end
    end

    

    def delete 
      @company = Company.find(params[:id])
      @company.destroy!

      respond_to do |format|
        format.html { redirect_to companies_path, notice: 'Company was successfully deleted.' }
        format.json { head :no_content }
        format.turbo_stream 
      end
    end

    private

    def company_params
      params.require(:company).permit(:name)
    end
  end
end
