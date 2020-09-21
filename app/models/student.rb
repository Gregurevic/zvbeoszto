class Student < ApplicationRecord
  
  belongs_to :instructor
  belongs_to :course

  validates :name, presence: true
  
  validates_format_of :neptun, with: /\A([A-Z]|[0-9]){6}\z/

end
