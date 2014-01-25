require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Workplace.blueprint do
  name { Faker::Company.name }
end

Role.blueprint do 
	name { 'Manager' }
end

User.blueprint do
	first_name { Faker::Name.first_name }
	last_name { Faker::Name.last_name }
	email { Faker::Internet.email }
end
