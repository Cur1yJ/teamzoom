class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"

  def welcome_email(user)
    @name = user.name_from_email
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => user.email, :subject => "Welcome to TeamZoom Site")
  end


  def request_installation(user)
    @user = user
    mail(
      to: "ryan.kruizenga@gmail.com",
      subject: "request for installation",
      from: @user,
      date: Time.now,
      content_type: "text/html"
    )
  end
end

