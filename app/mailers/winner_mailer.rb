class WinnerMailer < ApplicationMailer
  default from: 'from@example.com'

  def send_mail_to_winner(user, product)
    @user = user
    @product = product
    if @user != nil
      mail(to: @user.email, subject: "You have won " + product.title)
    end
  end
end
