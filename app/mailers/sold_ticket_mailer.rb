class SoldTicketMailer < ApplicationMailer
  default from: 'from@example.com'

  def mail_send_to_product_owner(user, product)
    @user = user
    @product = product
    if @user != nil
      mail(to: @user.email, subject: "Your Product all Tickets have been sold!")
    end
  end
end
