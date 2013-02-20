class UserMailer < ActionMailer::Base
  default from: "admin@teamzoom.com"

  def welcome_email(user)
    @name = user.name_from_email
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => user.email, :subject => "Welcome to TeamZoom Site")
  end

  def update_info(user)
    @name = user.name_from_email
    @url = url_for :controller=>'registrations', :action=>'edit'
    mail(:to => user.email, :subject => "You updated your profile")
  end

  def request_installation_to_admin(user)
   @admin=user
   @email=@admin.email
   mail(
      to: "admin@teamzoom.com",
      subject: "Request for an Installation",
      from: @email,
      date: Time.now,
      content_type: "text/html"
    )
  end

  def request_installation_to_user(user)
   @name = user.name
   @school=user.school
   mail(
      to: user.email,
      subject: "Your Request for an Installation from TeamZoom!",
      from: "admin@teamzoom.com",
      date: Time.now,
      content_type: "text/html"
    )
  end


end

