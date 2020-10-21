class AddPresenceToInstructors < ActiveRecord::Migration[6.0]
  def change
    add_column :instructors, :presence, :string
  end
end
