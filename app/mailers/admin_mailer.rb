class AdminMailer < ApplicationMailer
  default from: 'from@example.com'

  def promotion_send(user, promotion_obj)
    @user = user
    @promotion_obj = promotion_obj
    @url  = 'https://dev-traffle.herokuapp.com/'
    if @user != nil
      mail(to: @user.email, subject: @promotion_obj.subject)
    end
  end
end
