class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :student
      t.string :supervisor
      t.string :president
      t.string :secretary
      t.string :member
      t.string :examiner
      t.string :course

      t.timestamps
    end
  end
end
