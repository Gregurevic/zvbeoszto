class Student < ApplicationRecord

  belongs_to :instructor
  belongs_to :course

  validates :name, presence: true

  validates_format_of :neptun, with: /\A([A-Z]|[0-9]){6}\z/

  def delete_with_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM users WHERE rank = 'student' AND rank_id = #{self.id}")
      ActiveRecord::Base.connection.execute("DELETE FROM students WHERE id = #{self.id}")
    end
  end

  def delete_all_with_user
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM users WHERE rank = 'student'")
      ActiveRecord::Base.connection.execute("DELETE FROM students")
    end
  end

end
