class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :neptun
      t.string :email
      
      t.timestamps null: false
    end
  end
end
