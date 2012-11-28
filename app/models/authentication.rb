class Authentication < ActiveRecord::Base
  attr_accessible :provider, :secret, :token, :uid, :vi_employee_authentication_id
  belongs_to :vi_employee_authentication
end
