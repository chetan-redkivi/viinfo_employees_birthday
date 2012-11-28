class DeleteAndAddFieldsToAuthentications < ActiveRecord::Migration
  def up
    remove_column :authentications, :virtue_info_fb_connection_id
    add_column :authentications, :vi_employee_authentication_id,:integer
  end

  def down
  end
end
