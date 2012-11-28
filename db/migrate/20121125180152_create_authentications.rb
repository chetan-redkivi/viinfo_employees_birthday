class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :vi_employee_authentication_id
      t.string :uid
      t.string :provider
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
