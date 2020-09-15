class Instructor < ApplicationRecord

  has_many :students
  
  has_many :examiners
  has_many :courses, through: :examiners

  validates :name, presence: true
  
  validates :can_be_president,  inclusion: { in: [true, false] }
  validates :can_be_secretary,  inclusion: { in: [true, false] }
  validates :can_be_member,     inclusion: { in: [true, false] }

  validates_format_of :email, uniqueness: true, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i

end
