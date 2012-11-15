class EmployeeMailer < ActionMailer::Base
  default from: "chetankumar.virtueinfo@gmail.com"

  def birthday_reminder_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end


end
