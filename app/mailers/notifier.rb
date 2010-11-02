class Notifier < ActionMailer::Base
  #default :from => "from@example.com"
  default :from => "kaisen@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.ordered.subject
  #
  def ordered(order)
    @greeting = "Hi"
    @order = order

    #mail :to => "to@example.org"

    #mail :to => @order.email, :subject => "ご注文確認", :cc => "kaisen-admin@exsample.com"
    mail :to => @order.email, :subject => "ご注文確認"
  end
end
