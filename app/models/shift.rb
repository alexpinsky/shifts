class Shift < ActiveRecord::Base
	belongs_to :role
	has_many :assignments
	has_many :available_users, through: :role, source: :users
	has_many :assigned_users, through: :assignments, source: :user

	attr_accessible :role_id, :start_time, :end_time, :name, :assigned_user_ids

	def self.create_with_users(args={})
    begin
      ActiveRecord::Base.transaction do
        workplace = args[:workplace]
        shift = Shift.new(args[:shift_params])
        shift.workplace = workplace
        shift.save!
        args[:assigned_user_ids].each do |id|
        	user = workplace.users.find(id)
          Assignment.create(user: user, workplace: workplace, shift: shift)
        end
      end
    rescue Exception => e
    	binding.pry
      return {msg: e.message, shift: shift}      
    end
    {success: true}
  end
end