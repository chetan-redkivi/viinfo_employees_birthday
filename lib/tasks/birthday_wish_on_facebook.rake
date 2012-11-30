namespace :viinfo  do
  require 'koala'
  desc "Post a wishing message at friend's facebook wall who has birthday today."
  task :birthday_wish_on_facebook => :environment do
  vi_employees  = ViEmployeeAuthentication.all(:joins =>:authentication)
    if vi_employees.present?
      wishing_at_facebook_wall(vi_employees)
    end
  end
end

def wishing_at_facebook_wall(vi_employees)
  begin
    @current_date = DateTime.now.new_offset(5.5/24).strftime('%m-%d-%Y').split('-')
    current_month = DateTime.now.new_offset(5.5/24).strftime('%b')
    puts "Current Date: #{@current_date}"
    vi_employees.each do |employee|
      @today_birthday = []
      @graph = Koala::Facebook::API.new("#{employee.authentication.token}")
      @friends_profile = @graph.get_connections(employee.authentication.uid, "friends", "fields"=>"name,birthday,gender,link")
      me = @graph.get_object("#{employee.authentication.uid}")      
      puts "I m #{me["first_name"]} who is wishing my friend's birthday."		
      puts "Employee Email who is wishing birthday #{employee.email}"		
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
      puts @today_birthday
      unless @today_birthday.blank?
        @today_birthday.each do |birthday_person|
          #@graph.put_wall_post("Happy Birthday..!!!!",birthday_person["id"])
          #@graph.put_object(birthday_person["id"], "feed", :message => "Wishing you a very special Happy Birthday..!!!!")
          puts "Posted on wall successfully"
        end
      end
    end
  rescue Exception => e
    Rails.logger.info("===========================================>Error Message: #{e}")
    Rails.logger.info("===========================================> Internet connection not available or may be it is very slow.")
  end
end

