class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = current_user.contacts.order(:name)
    render json: @contacts
  end

  def show
    render json: @contact
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    head :no_content
  end

  def search_address
    if params[:zip]
      response = HTTParty.get("https://viacep.com.br/ws/#{params[:zip]}/json/")
      if response.success?
        render json: response.parsed_response
      else
        render json: { error: 'Endereço não encontrado' }, status: :not_found
      end
    else
      render json: { error: 'CEP não informado' }, status: :bad_request
    end
  end  

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :cpf, :phone, :address, :city, :state, :zip, :latitude, :longitude)
  end
end
