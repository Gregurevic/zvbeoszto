class CreateExaminers < ActiveRecord::Migration[6.0]
  def change
    create_table :examiners do |t|
      t.references :course, null: false, foreign_key: true
      t.references :instructor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
