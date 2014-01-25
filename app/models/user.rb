class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :location, as: :locationable
  has_many :employments, dependent: :destroy
  has_many :workplaces, through: :employments
  has_many :roles, through: :employments
  has_many :shifts, through: :assignments

  def self.create_with_roles(args={})
    begin
      user = nil
      ActiveRecord::Base.transaction do
        user = User.new(args[:user_params])
        user.password = Devise.friendly_token
        user.save!
        workplace = args[:workplace]
        workplace.add_employee!(user)
        args[:role_ids].each do |id|
          Employment.create!(user: user, workplace: workplace, role_id: id)
        end
      end
    rescue Exception => e
      return { msg: e.message, user: user }      
    end
    { success: true, user: user }
  end

  def self.update_with_roles(args={})
    begin
      ActiveRecord::Base.transaction do
        user = args[:user]
        user.update!(args[:user_params])
        workplace = args[:workplace]
        role_ids = args[:role_ids]
        current_employments = user.employments.by_workplace(workplace)
        current_employments.where("employments.role_id NOT IN (?)", role_ids).destroy_all
        existing_role_ids = current_employments.map(&:role_id)
        new_role_ids = role_ids - existing_role_ids
        new_role_ids.each do |id|
          Employment.create!(user: user, workplace: workplace, role_id: id)
        end
      end
    rescue Exception => e
      return { msg: user.errors.full_messages, user: user}
    end
    { success: true, user: user }
  end

  def display_name
    "#{self.first_name} #{self.last_name}"
  end
end
