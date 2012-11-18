class EmployeeMailer < ActionMailer::Base
  default from: "chetankumar.virtueinfo@gmail.com"

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
end
