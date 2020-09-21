class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #, :confirmable

  validates :rank, acceptance: { accept: ['admin', 'instructor', 'student'] }
  validates :rank_id, numericality: { only_integer: true }, allow_nil: true

  def is_admin?
  	self.rank == 'admin'
  end

  def is_instructor?
  	self.rank == 'instructor'
  end

end
