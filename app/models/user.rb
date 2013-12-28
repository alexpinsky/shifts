class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :location, as: :locationable
  has_many :employments, dependent: :destroy
  has_many :work_places, through: :employments
  has_many :roles, through: :employments
  has_many :shifts, through: :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :birthday

  def self.create_with_roles(args={})
    begin
      ActiveRecord::Base.transaction do
        user = User.new(args[:user_params])
        user.password = Devise.friendly_token
        user.save!
        work_place = args[:work_place]
        args[:role_ids].each do |id|
          Employment.create(user: user, work_place: work_place, role_id: id)
        end
      end
    rescue Exception => e
      return {msg: e.message, user: user}      
    end
    {success: true}
  end
end
