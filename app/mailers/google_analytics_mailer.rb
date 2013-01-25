class GoogleAnalyticsMailer < ActionMailer::Base
	default :from => "teamzoom_report@teamzoom.com"
  def report_mail(team, email, total_raise, chart_url, last_action)
    @email  = email
    @total_raise = total_raise
    @chart_url = chart_url
    @team = team
    @url  = "http://teamzoom.com"
    @last_action = last_action
    mail(:to => email,
      :subject => "Report total views",
      :template_path => 'admin/transactions',
      :template_name => 'report_mail')
  end
end
