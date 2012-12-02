class HomeController < ApplicationController
  require 'chagol'

  def index
    @custom_message = CustomMessage.new
    begin
      if current_vi_employee_authentication.present?
        if current_vi_employee_authentication.authentication.present?
          current_month, token, uid = initialise_objects()
          begin
            @graph = Koala::Facebook::API.new("#{token}")
            @friends_profile = @graph.get_connections("#{uid}", "friends", "fields"=>"name,birthday,gender,link")
            @me =  @graph.get_object("#{uid}")
          rescue Exception => e
            flash[:notice] = "Not able to fetch friends birthday"
            Rails.logger.info("=============================>Facebook Graph API ERROR: #{e.message}")
          end
          @today_birthday = []
          get_todays_and_next_birthdays(current_month)
        end
      end
    rescue Exception => e
      flash[:notice]  = "Something went wrong.. Please check your internet connection."
      Rails.logger.info("================================> #{e.message}")
    end
  end

  def initialise_objects
    @current_date = DateTime.now.new_offset(5.5/24).strftime('%m-%d-%Y').split('-')
    current_month = DateTime.now.new_offset(5.5/24).strftime('%B')
    @total_days = (Date.new(Time.now.year, 12, 31).to_date<<(12-(DateTime.now.strftime('%m')).to_i)).day
    @upcoming = @current_date[1].to_i+10
    @first_upcoming_birthday = []
    @nxt_upcoming_birthday = []
    @next_month_bday = []
    uid = current_vi_employee_authentication.authentication.uid
    token = current_vi_employee_authentication.authentication.token
    return current_month, token, uid
  end

  def get_todays_and_next_birthdays(current_month)
    @friends_profile.each do |friend|
      if !friend["birthday"].nil?
        birthday = friend["birthday"].split('/')
        if @current_date[0] == birthday[0]
          #month is same
          if @current_date[1]==birthday[1]
            #Date is same
            #@today_birthday << friend["id"]
            @today_birthday << {"name" => friend["name"], "birthday" => "#{birthday[1]}"+" #{current_month}", "id" => friend["id"], "link" => friend["link"], "gender" => friend["gender"]}
          end
          if birthday[1].to_i > @current_date[1].to_i && birthday[1].to_i < @upcoming
            @first_upcoming_birthday << {"name" => friend["name"], "birthMonth" => birthday[0], "birthDate" => birthday[1], "birthday" => birthday[1]+" #{current_month}", "id" => friend["id"], "link" => friend["link"], "flag" => 1, "gender" => friend["gender"]}
          end

        elsif birthday[0].to_i == @current_date[0].to_i+1
          if birthday[1].to_i >=1 && birthday[1].to_i < (@upcoming-@total_days.to_i)
            @nxt_upcoming_birthday << {"name" => friend["name"], "birthMonth" => birthday[0], "birthDate" => birthday[1], "birthday" => birthday[1]+" #{(DateTime.now + 1.month).new_offset(5.5/24).strftime('%B')}", "id" => friend["id"], "link" => friend["link"], "gender" => friend["gender"]}
          end
          @next_month_bday << {"name" => friend["name"], "birthday" => birthday[1], "id" => friend["id"]}
        end
        if !@nxt_upcoming_birthday.blank?
          @nxt_upcoming_birthdays = @nxt_upcoming_birthday.sort_by { |hsh| hsh["birthday"] }
          @nxt_upcoming_birthdays = @first_upcoming_birthday+@nxt_upcoming_birthday
        else
          @nxt_upcoming_birthdays = @first_upcoming_birthday
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
