
class UserMailer < ActionMailer::Base
  default from: "admin@teamzoom.com"

  def welcome_email(user)
    @name = user.name_from_email
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => user.email, :subject => "Welcome to TeamZoom!")
  end
  
   def update_info(user)
    @name = user.name_from_email
    @url = url_for :controller=>'registrations', :action=>'edit'
    mail(:to => user.email, :subject => "You have updated your profile successfully!")
  end


  def request_installation(user)
    @user = user
    mail(
	  to: "mike@michaellungo.com",
      subject: "request for installation",
      from: @user,
      date: Time.now,
      content_type: "text/html"
    )
  end
end

