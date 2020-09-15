class CreateInstructors < ActiveRecord::Migration[6.0]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.boolean :can_be_president
      t.boolean :can_be_secretary
      t.boolean :can_be_member

      t.timestamps null: false
    end
  end
end
