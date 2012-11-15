namespace :viinfo  do
  desc "Send birthday notification to all employees"
  task :birthday_notification => :environment do
    @user = User.all.first
    employees = Employee.all
    employees.each do |employee|
      EmployeeMailer.birthday_reminder_email(@user).deliver
    end
  end
end


