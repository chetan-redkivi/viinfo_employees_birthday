class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth
      t.boolean :status

      t.timestamps
    end
  end
end
