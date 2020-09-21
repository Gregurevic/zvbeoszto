class Instructor < ApplicationRecord

  has_many :students
  
  has_many :examiners
  has_many :courses, through: :examiners
  
  validates :name, presence: true
  validates :can_be_president,  inclusion: { in: [true, false] }
  validates :can_be_secretary,  inclusion: { in: [true, false] }
  validates :can_be_member,     inclusion: { in: [true, false] }

  def instructor_save
    @instructor.valid?
    Instructor.create( name: :name,
                       can_be_president: :can_be_president,
                       can_be_secretary: :can_be_secretary,
                       can_be_member: :can_be_member )
  end

end
