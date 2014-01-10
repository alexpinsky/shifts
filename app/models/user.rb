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
      ActiveRecord::Base.transaction do
        user = User.new(args[:user_params])
        user.password = Devise.friendly_token
        user.save!
        workplace = args[:workplace]
        args[:role_ids].each do |id|
          Employment.create(user: user, workplace: workplace, role_id: id)
        end
      end
    rescue Exception => e
      return {msg: e.message, user: user}      
    end
    {success: true}
  end

  def display_name
    "#{self.first_name} #{self.last_name}"
  end
end
