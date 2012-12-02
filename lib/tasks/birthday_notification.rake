namespace :viinfo  do
  require 'koala'
  desc "Send birthday notification to all employees"
  task :birthday_notification => :environment do
    puts "=================================>Rake Task Begin"

    current_date = DateTime.now.new_offset(5.5/24).strftime('%a, %d %b %Y').to_date
    employees_who_have_birthday_today = Employee.where('date_of_birth =?',current_date)
    if employees_who_have_birthday_today.nil? || employees_who_have_birthday_today.blank?
      @send_mail  = false
    else
      @person_names = []
      @send_mail  = true
      employees_who_have_birthday_today.each do |birthday_person|
        @send_mail
        @person_names << birthday_person.name
      end
    end
    employees = Employee.all
    auth = Chagol::SmsSender.new("#{ENV["COMPANY_WAYTOSMS_NO"]}","#{ENV["WAYTOSMS_PSWD"]}","#{ENV["PROVIDER"]}")
    if employees.present?
      employees.each do |employee|
        unless employee.email.nil?
          is_employee_has_birthday = employees_who_have_birthday_today.include?(employee)
          if @send_mail
            if is_employee_has_birthday
              begin
                auth.send("#{employee.phone_number}", "Virtue-Info-BirthDay-Wish: Hi #{employee.name}, Virtue-Info Family Wishing You a Very Special Birthday.")
              rescue Exception => e
                puts "=================================>Error Message For SMS:  #{e.message}"
              end
              begin
              puts "=================================== Mail send Successfully"
               EmployeeMailer.birthday_wish_email(employee).deliver
              rescue
                puts "=================================== Mail not send"
              end
            else
              if @person_names.size > 1
                @names = @person_names.join(',')
              else
                @names = @person_names[0]
              end
              begin
                auth.send("#{employee.phone_number}", "Viinfo-BirthDay-Alert: Today #{@names} has birthday.")
                puts "---------------------------SMS send at #{employee.phone_number}, Name: #{@names}---------------------------"
              rescue Exception => e
                puts "---------------------------#{e.message}---------------------------"
              end
              begin
                EmployeeMailer.birthday_reminder_email(employee,@names).deliver
                puts "======================================> Reminder Mail Send Successfully"
              rescue Exception => e
                puts "======================================> Reminder Mail not send: Error: #{e.message}"
              end
            end
          end
        end
      end
    else
      puts "===============================> No employee present to Send mail"
    end
  end
end