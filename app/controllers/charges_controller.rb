class ChargesController < ApplicationController
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
     amount: 15_00,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
   )

   current_user.premium!
   flash[:notice] = "Congratulations, #{current_user.email}! You are now a premium member."
   redirect_to root_path


   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message

     redirect_to premium_registration_path
 end





end
