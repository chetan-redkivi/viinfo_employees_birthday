namespace :viinfo  do
  desc "Send birthday notification to all employees"
  task :birthday_notification => :environment do
    @user = User.all.first
    current_date = DateTime.now.new_offset(5.5/24).strftime('%a, %d %b %Y').to_date

    employees_who_have_birthday_today = Employee.where('date_of_birth =?',current_date)
    unless employees_who_have_birthday_today.blank?
      @person_names = []
      employees_who_have_birthday_today.each do |birthday_person|
        @person_names << birthday_person.name
      end
    end
    employees = Employee.all
    employees.each do |employee|
      unless employee.email.nil?
        is_employee_has_birthday = employees_who_have_birthday_today.include?(employee)

        if is_employee_has_birthday
          EmployeeMailer.birthday_wish_email(employee).deliver
        else
          EmployeeMailer.birthday_reminder_email(employee,@person_names.join(',')).deliver
        end

      end
    end
  end
end


