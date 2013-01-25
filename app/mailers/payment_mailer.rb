class PaymentMailer < ActionMailer::Base
  default from: "admin@teamzoom.com"

  def single_game(user, order)
    @user = user
    @order = order
    mail(to: user.email, subject: "Thank you for purchasing a single game")
  end

  def monthly_subscription(user, order)
    @user = user
    @order = order
    mail(to: user.email, subject: "Thank you for monthly subscription")
  end
end
