class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :neptun
      t.string :supervisor_neptun
      t.string :course_neptun
    end
  end
end
