class Instructor < ApplicationRecord

  has_many :students
  
  has_many :examiners
  has_many :courses, through: :examiners
  
  validates :name, presence: true
  validates :can_be_president,  inclusion: { in: [true, false] }
  validates :can_be_secretary,  inclusion: { in: [true, false] }
  validates :can_be_member,     inclusion: { in: [true, false] }

  attr_accessor :course_list
  attr_accessor :present_hours
  
  def safe_delete
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DELETE FROM examiners WHERE instructor_id = #{self.id}")
      ActiveRecord::Base.connection.execute("UPDATE students SET instructor_id = NULL WHERE instructor_id = #{self.id}")
      ActiveRecord::Base.connection.execute("DELETE FROM instructors WHERE id = #{self.id}")
    end
  end
end
