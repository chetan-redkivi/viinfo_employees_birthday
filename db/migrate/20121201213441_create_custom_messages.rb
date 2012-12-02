class CreateCustomMessages < ActiveRecord::Migration
  def change
    create_table :custom_messages do |t|
      t.string :friend_uid
      t.text :message

      t.timestamps
    end
  end
end
