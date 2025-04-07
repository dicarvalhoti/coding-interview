class UsersController < ApplicationController

  def index
    #change param :company_identifier to :company_id
    
    users = User
              .by_company(params[:company_id])
              .by_username(search_params[:username])
    render json: users.all
  end

  private

  def search_params
    params.permit(:username)
  end

end
