class Employee < ActiveRecord::Base
  attr_accessible :date_of_birth, :email, :name, :status,:phone_number
end
