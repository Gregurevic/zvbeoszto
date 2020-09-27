class Course < ApplicationRecord

  has_many :students
  
  has_many :examiners
  has_many :instructors, through: :examiners

  validates :name, presence: true

  validates_format_of :neptun, with: /\ABMEVI([A-Z]){3}([A-Z]|[0-9]){3}\z/

  def safe_delete
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM examiners WHERE course_id = #{self.id}")
      ActiveRecord::Base.connection.execute("UPDATE students SET course_id = NULL WHERE course_id = #{self.id}")
      ActiveRecord::Base.connection.execute("DELETE FROM courses WHERE id = #{self.id}")
    end
  end
end
