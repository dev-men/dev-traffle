class User::WithdrawsController < ApplicationController
  before_action :authenticate_user!

  def request_for_withdraw
    if current_user.recipient == nil
      redirect_to new_user_withdraw_path
    else
      desc = current_user.name + " has requested his funds for withdraw. His balance is: " + current_user.balance.to_s
      @request = Request.new(:user_id => current_user.id, :description => desc, :status => false)
      @request.save
      flash[:notice] = "Your request for withdraw balance is send to admin!"
      redirect_to user_dashboard_path(current_user.id)
    end
  end

  def new
    @recipient = Recipient.new
  end

  def create
    #debugger
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    recipient = PaystackRecipients.new(paystackObj)
    result = recipient.create(
  		:type => "nuban", #Must be nuban
  		:name => params['recipient']['name'],
  		:description => params['recipient']['description'],
  		:account_number => params['recipient']['account_number'], #10 digit account number
  		:bank_code => params['recipient']['bank_code'], #monthly, yearly, quarterly, weekly etc
  		:currency => "NGN"
    )

    @recipient = Recipient.new(:user_id => current_user.id, :name => result['data']['name'], :description => result['data']['description'], :account_number => result['data']['details']['account_number'],
                               :bank_code => result['data']['details']['bank_code'], :recipient_code => result['data']['recipient_code'],  :paystack_recipient_id => result['data']['id'])

    @recipient.save

    desc = current_user.name + " has requested his funds for withdraw. His balance is: " + current_user.balance.to_s
    @request = Request.new(:user_id => current_user.id, :description => desc, :status => false)
    @request.save
    flash[:notice] = "Your request for withdraw balance is send to admin!"
    redirect_to user_dashboard_path(current_user.id)

  end


end
