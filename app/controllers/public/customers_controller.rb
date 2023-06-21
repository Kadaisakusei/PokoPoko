class Public::CustomersController < ApplicationController

   def show
    @customer = Customer.find(params[:id])
    @illustrations = @customer.illustrations
    @illustration = Illustration.new
   end

  def edit
    @customer = Customer.find(params[:id])
     if @customer == current_customer
       render :edit
     else
       redirect_to customer_path(current_customer)
     end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "User-introduction was successfully updated."
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def index
    @customers = Customer.all
    @illustration = Illustration.new
    @customer = current_customer

  end

  def withdraw
    if current_customer.update(is_deleted: true)
       reset_session
       redirect_to root_path
    else
      render :edit
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:is_deleted, :name, :introduction, :profile_image)
    end

end
