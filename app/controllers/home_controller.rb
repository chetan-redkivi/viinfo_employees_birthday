class HomeController < ApplicationController
  require 'chagol'

  def index
    @graph = Koala::Facebook::API.new('AAAGg0P6LI3IBACVGic40QiYt3ytQSrOWtTCuQ7mAAZAhcIr7pWYeVeYXEb1cbDPIuv7Qd0x70MRoKwfn0S6LEityqyZBs1SrDKQF22dQZDZD')
    @current_date = DateTime.now.new_offset(5.5/24).strftime('%m-%d-%Y').split('-')
    current_month = DateTime.now.new_offset(5.5/24).strftime('%b')
    @friends_profile = @graph.get_connections("me", "friends", "fields"=>"name,birthday,gender,link")
    @today_birthday = []
    @friends_profile.each do |friend|
      if !friend["birthday"].nil?
        birthday = friend["birthday"].split('/')
        if @current_date[0] == birthday[0]
          #month is same
          if @current_date[1]==birthday[1]
            #Date is same
            #@today_birthday << friend["id"]
            @today_birthday <<  {"name" => friend["name"],"birthday" => "#{birthday[1]}"+" #{current_month}","id" => friend["id"],"link" => friend["link"]}
          end
        end
      end
    end
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
