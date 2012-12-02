class ViEmployeeAuthentications::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	#require 'koala'
  def facebook
		data = request.env["omniauth.auth"].extra.raw_info
    session[:access_token] = request.env["omniauth.auth"].credentials.token
		if data.email.nil?
				@email = data.link
		else
			@email = data.email
		end
    @auth = Authentication.find_by_uid_and_vi_employee_authentication_id(data.uid,@email)

    if @auth.nil?
      authentication = Authentication.new
      authentication.uid = request.env["omniauth.auth"].uid
      authentication.provider = request.env["omniauth.auth"].provider
      authentication.token = request.env["omniauth.auth"].credentials.token
      authentication.secret = request.env["omniauth.auth"].credentials.secret
      authentication.vi_employee_authentication_id = current_vi_employee_authentication.id
      authentication.save
	end
    redirect_to root_url
  end


end
