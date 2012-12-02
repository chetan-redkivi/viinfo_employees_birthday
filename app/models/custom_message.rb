class CustomMessage < ActiveRecord::Base
  attr_accessible :friend_uid, :message,:vi_employee_authentication_id
  belongs_to :vi_employee_authentication
end
