class DeleteAndAddFieldsToAuthentications < ActiveRecord::Migration
  def up
    add_column :authentications, :vi_employee_authentication_id,:integer
  end

  def down
  end
end
