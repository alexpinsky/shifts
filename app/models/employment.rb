class Employment < ActiveRecord::Base
	belongs_to :workplace
	belongs_to :user
	belongs_to :role

	validates_presence_of :workplace
  validates_presence_of :user
  validates_presence_of :role
  validates_uniqueness_of :role_id, scope: [:workplace_id, :user_id]

  scope :by_workplace, -> (workplace) { where("employments.workplace_id = ?", workplace.id) }

  before_destroy :validate_workplace_connection

  def validate_workplace_connection
  	return if self.name != Role::WORKPLACE_CONNECTION
  	errors[:base] << "Cannot delete the workplace connection"
  end
end