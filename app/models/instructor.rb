class Instructor < ApplicationRecord

  has_many :students
  
  has_many :examiners
  has_many :courses, through: :examiners
  
  validates :name, presence: true
  validates :can_be_president,  inclusion: { in: [true, false] }
  validates :can_be_secretary,  inclusion: { in: [true, false] }
  validates :can_be_member,     inclusion: { in: [true, false] }

end
