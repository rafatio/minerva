class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_USERNAME"]

  def payment_confirmation_email(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'Confirmação de pagamento')
  end

end
