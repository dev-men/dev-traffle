include Rails.application.routes.url_helpers
class OthersMailer < ApplicationMailer
  default from: 'from@example.com'

  def send_to_product_other(user, product, winner)
    attachments.inline['logo_512.png'] = File.read('app/assets/images/logo_128.png')
    @user = user
    @product = product
    @winner = winner
    if @user != nil
      mail(to: @user.email, subject: "Sorry, You lose!")
    end
  end
end
