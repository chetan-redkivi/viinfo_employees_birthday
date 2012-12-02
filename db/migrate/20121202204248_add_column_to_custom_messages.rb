class AddColumnToCustomMessages < ActiveRecord::Migration
  def change
    add_column :custom_messages,:vi_employee_authentication_id,:integer
  end
end
