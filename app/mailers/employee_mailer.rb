class EmployeeMailer < ActionMailer::Base
  default from: "forchetan01@gmail.com"

  def birthday_wish_email(employee)
    @employee = employee
    mail(:to => @employee.email, :subject => "Happy Birthday #{@employee.name}")
  end

  def birthday_reminder_email(employee,person_names)
    @employee = employee
    @birthday_person_name = person_names
    @url  = "http://example.com/login"
    mail(:to => @employee.email, :subject => "Today, some has Birthday")
  end

  def confirmation_email_after_post_at_fb_wall(employee,friend_name)
    @employee = employee
    @friend_name = friend_name
    mail(:to => @employee.email, :subject => "Successfully posted on facebook wall")
  end

end
