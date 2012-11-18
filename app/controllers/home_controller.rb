class HomeController < ApplicationController
  def index
  end

  def send_email
    current_date = DateTime.now.new_offset(5.5/24).strftime('%a, %d %b %Y').to_date
    employee_who_has_birthday_today = Employee.where('date_of_birth =?',current_date)
    render :text => employee_who_has_birthday_today.inspect and return false

    #EmployeeMailer.birthday_reminder_email(@user).deliver
    #redirect_to root_path
  end
end
