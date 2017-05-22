class ChargesController < ApplicationController

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium",
    #  amount: Amount.default
     amount: 1500
   }
  end

  def create

     # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: 1500,
       description: "Blocipedia Premium - #{current_user.email}",
       currency: 'usd'
     )

     current_user.update(role: 1)
     flash[:notice] = "You've upgraded your account to Premium, #{current_user.email}!"
     redirect_to root_path # redirects to home page

     # Stripe will send back CardErrors, with friendly messages
     # when something goes wrong.
     # This `rescue block` catches and displays those errors.
     rescue Stripe::CardError => e
       flash[:alert] = e.message
       redirect_to new_charge_path
   end

end
