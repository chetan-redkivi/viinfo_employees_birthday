class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :virtue_info_fb_connection_id
      t.string :uid
      t.string :provider
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
