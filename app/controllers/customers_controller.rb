# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  # GET /customers or /customers.json
  def index
    @search = CustomerSearch.new(params[:search])

    @customers = @search.scope
    @customers = Customer.all

    respond_to do |fmt|
      fmt.html
      fmt.csv { send_data(@customers.to_csv(%w[first_name last_name email date_of_birth])) }
    end
  end

  # GET /customers/1 or /customers/1.json
  def show; end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit; end

  # IMPORT Data
  def import
    Customer.import(params[:data])

    redirect_to(customers_path, notice: 'Customers successfully imported.')
  end

  # def import
  #   data = File.join Rails.root, 'db', 'data.csv'
  #   ImportWorker.perform_async(data)

  #   flash[:notice] = 'Data is added into App'
  #   redirect_to customers_path
  # end

  # def destroy_all
  #   DestroyWorker.perform_async
  #   flash[:notice] = 'Data was removed from App'

  #   redirect_to customers_path
  # end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer
      respond_to do |format|
        if @customer.save!
          format.html { redirect_to(@customer, notice: 'Customer was successfully created.') }
          format.json { render(:show, status: :created, location: @customer) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @customer.errors, status: :unprocessable_entity) }
        end
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to(@customer, notice: 'Customer was successfully updated.') }
        format.json { render(:show, status: :ok, location: @customer) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @customer.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy!
    respond_to do |format|
      format.html { redirect_to(customers_url, notice: 'Customer was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:date, :first_name, :last_name, :email, :date_of_birth)
  end
end
