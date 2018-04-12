include Rails.application.routes.url_helpers
class WinnerMailer < ApplicationMailer
  default from: 'from@example.com'

  def send_mail_to_winner(user, product)
    attachments.inline['logo_512.png'] = File.read('app/assets/images/logo_128.png')
    @user = user
    @product = product
    if @user != nil
      mail(to: @user.email, subject: "You have won " + product.title)
    end
  end
end