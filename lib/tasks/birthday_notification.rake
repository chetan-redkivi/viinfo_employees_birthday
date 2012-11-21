namespace :viinfo  do
  desc "Send birthday notification to all employees"
  task :birthday_notification => :environment do
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
    auth = Chagol::SmsSender.new("8460455479","Q982919R","way2sms")
    employees.each do |employee|
      unless employee.email.nil?
        is_employee_has_birthday = employees_who_have_birthday_today.include?(employee)
        if @send_mail
          if is_employee_has_birthday
            EmployeeMailer.birthday_wish_email(employee).deliver
          else
            if @person_names.size > 1
              @names = @person_names.join(',')
            else
              @names = @person_names[0]
            end
            begin
              auth.send("9898865672", "Viinfo-BirthDay-Alert: Today #{@names} has birthday.")
            rescue Exception => e
              Rails.logger.info("---------------------------#{e.message}---------------------------")
            end
            EmployeeMailer.birthday_reminder_email(employee,@names).deliver
          end
        end
      end
    end
  end
end


