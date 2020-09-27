class Course < ApplicationRecord

  has_many :students
  
  has_many :examiners, dependent: :delete_all
  has_many :instructors, through: :examiners

  validates :name, presence: true

  validates_format_of :neptun, with: /\ABMEVI([A-Z]){3}([A-Z]|[0-9]){3}\z/

end
