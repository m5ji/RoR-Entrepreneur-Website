class WelcomeController < ApplicationController
  def index
	@files = Model.all
  end

  def new

  end
  
  def show
	@file = Model.find(params[:id])

        customer = Stripe::Customer.create(
  	  :email => params[:stripeEmail],
  	  :card  => params[:stripeToken]
 	 )

 	 charge = Stripe::Charge.create(
   	 :customer    => customer.id,
   	 :amount      => @file.Price * 100,
   	 :description => @file.Description,
   	 :currency    => 'cad'
 	 )

        @file.update(Status: "Purchased")
        redirect_to welcome_index_path

  end

  def create
	@file = Model.new(myparams)
	@file.Status = "Uploaded"
	@file.Price = @file.Price.to_f
	if @file.save
	  redirect_to new_welcome_path
	else
	  redirect_to welcome_index_path
	end
  end

  def update
  
  end

  def destroy
    @file = Model.find(params[:id])
    @file.destroy
    redirect_to welcome_index_path
  end

  private
    def myparams
    	params.require(:file).permit(:Name, :url, :Description, :Price, :Status)
    end
  private
    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

end
