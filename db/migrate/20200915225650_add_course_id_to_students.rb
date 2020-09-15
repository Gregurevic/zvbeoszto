class AddCourseIdToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :course, null: false, foreign_key: true
  end
end
