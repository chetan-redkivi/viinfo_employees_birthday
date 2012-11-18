# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path(File.dirname(__FILE__) + "/environment")
# Example:
#
 set :output, "/var/www/rails_apps/viinfo_employees_birthday/public/birthday_notifications/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 1.days  do
  rake "viinfo:birthday_notification"
end

# Learn more: http://github.com/javan/whenever
