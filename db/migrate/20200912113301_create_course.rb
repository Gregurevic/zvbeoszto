class CreateCourse < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :neptun
    end
  end
end
