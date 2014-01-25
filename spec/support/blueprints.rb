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
