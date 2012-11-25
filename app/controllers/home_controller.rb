class HomeController < ApplicationController
  require 'chagol'

  def index

  end

  def send_email
    begin
      texter = Chagol::SmsSender.new("8460455479","Q982919R","way2sms")
      texter.send("9898865672", "Viinfo-BirthDay-Alert: Today Chetan has birthday.")
      Rails.logger.info("==================================================Message Sent Successfully=====================================================================")

    rescue Exception => e
      Rails.logger.info("=====================================================================#{e.message}=====================================================================")
    end
    #current_date = DateTime.now.new_offset(5.5/24).strftime('%a, %d %b %Y').to_date
    #employee_who_has_birthday_today = Employee.where('date_of_birth =?',current_date)
    #render :text => employee_who_has_birthday_today.inspect and return false

    #EmployeeMailer.birthday_reminder_email(@user).deliver
    #redirect_to root_path
  end
end
