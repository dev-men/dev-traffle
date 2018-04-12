include Rails.application.routes.url_helpers

class AdminMailer < ApplicationMailer
  default from: 'from@example.com'

  def promotion_send(user, promotion_obj)
    attachments.inline['logo_512.png'] = File.read('app/assets/images/logo_128.png')
    @user = user
    @promotion_obj = promotion_obj
    if @user != nil
      mail(to: @user.email, subject: @promotion_obj.subject)
    end
  end
end
