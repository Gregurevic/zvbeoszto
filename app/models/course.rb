class Course < ApplicationRecord

  has_many :instructors

  validates :name, presence: true

  validates_format_of :neptun, with: /\ABMEVI([A-Z]){3}([A-Z]|[0-9]){3}\z/i

end