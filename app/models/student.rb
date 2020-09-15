class Student < ApplicationRecord
  
  belongs_to :instructor
  belongs_to :course

  validates :name, presence: true

  validates_format_of :email, uniqueness: true, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
  validates_format_of :neptun, with: /\A([A-Z]|[0-9]){6}\z/i

end
