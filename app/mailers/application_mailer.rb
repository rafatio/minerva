# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  add_template_helper(EmailHelper)

  default from: ENV['EMAIL_USERNAME']

  def payment_confirmation_email(user, payment)
    @user = user
    @payment = payment
    mail(to: @user.email, subject: 'Obrigado pela sua contribuição!')
  end
end
