class CreateInstructors < ActiveRecord::Migration[6.0]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :neptun
      t.boolean :can_be_president
      t.boolean :can_be_secretary
      t.boolean :can_be_member
    end
  end
end
