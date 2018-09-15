class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  
  def payment_confirmation_email(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'Confirmação de pagamento')
  end

end
